# frozen_string_literal: true

require 'erb'
require 'yaml'

module SyspaySDK
  module Configuration
    def config
      @config ||= Config.config
    end

    def set_config(env, override_configurations = {})
      return @config = env if env.is_a? Config

      if env.is_a? Hash
        return @config = begin
          config.dup.merge!(env)
        rescue Errno::ENOENT
          Config.new(env)
        end
      end

      @config = Config.config(env, override_configurations)
    end

    alias config= set_config
  end

  class Config
    include Logging
    include Exceptions

    attr_accessor :syspay_mode,
                  :syspay_id,
                  :syspay_passphrase,
                  :syspay_threatmetrix_code,
                  :syspay_js_key,
                  :syspay_org_id,
                  :syspay_retry_map_id,
                  :syspay_base_url

    def initialize(options)
      merge!(options)
    end

    def ssl_options
      @ssl_options ||= {}.freeze
    end

    def ssl_options=(options)
      options = Hash[options.map { |key, value| [key.to_sym, value] }]
      @ssl_options = ssl_options.merge(options).freeze
    end

    def merge!(options)
      options.each do |key, value|
        send("#{key}=", value)
      end
      self
    end

    def required!(*names)
      names = names.select { |name| send(name).nil? }

      return unless names.any?

      raise MissingConfig, "Required configuration(#{names.join(', ')})"
    end

    class << self
      @config_cache = {}

      def load(filename, default_env = default_environment)
        @config_cache        = {}
        @configurations      = read_configurations(filename)
        @default_environment = default_env
        config.required!(
          :syspay_mode, :syspay_id, :syspay_passphrase, :syspay_threatmetrix_code,
          :syspay_js_key, :syspay_org_id, :syspay_base_url, :syspay_retry_map_id
        )
      end

      def default_environment
        @default_environment ||=
          ENV['SYSPAY_ENV'] ||
          ENV['RACK_ENV'] ||
          ENV['RAILS_ENV'] ||
          'development'
      end

      def default_environment=(env)
        @default_environment = env.to_s
      end

      def configure(options = {}, &block)
        begin
          config.merge!(options)
        rescue Errno::ENOENT
          self.configurations = { default_environment => options }
        end

        yield(config) if block

        config
      end

      alias set_config configure

      def config(env = default_environment, override_configuration = {})
        if env.is_a? Hash
          override_configuration = env
          env = default_environment
        end

        if override_configuration.nil? || override_configuration.empty?
          default_config(env)
        else
          default_config(env).dup.merge!(override_configuration)
        end
      end

      def default_config(env = nil)
        env = (env || default_environment).to_s

        unless configurations[env]
          raise Exceptions::MissingConfig, "Configuration[#{env}] NotFound"
        end

        @config_cache[env] ||= new(configurations[env])
      end

      def logger=(logger)
        Logging.logger = logger
      end

      def logger
        Logging.logger
      end

      def configurations
        @configurations ||= read_configurations
      end

      def configurations=(configs)
        @config_cache   = {}
        @configurations = configs && Hash[configs.map { |k, v| [k.to_s, v] }]
      end

      private

      def read_configurations(filename = 'config/syspay.yml')
        erb = ERB.new(File.read(filename))
        erb.filename = filename
        YAML.safe_load(erb.result, [], [], true)
      end
    end
  end
end
