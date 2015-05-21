require 'erb'
require 'yaml'

module Syspay::SDK
  module Configuration
    def config
      @config ||= Config.config
    end

    def set_config(env, override_configurations = {})
      @config =
      case env
      when Config
        env
      when Hash
        begin
          config.dup.merge!(env)
        rescue Errno::ENOENT => error
          Config.new(env)
        end
      else
        Config.config(env, override_configurations)
      end
    end

    alias_method :config=, :set_config
  end

  class Config
    include Logging
    include Exceptions

    attr_accessor :syspay_mode, :syspay_id, :syspay_passphrase, :syspay_threatmetrix_code, :syspay_js_key

    def initialize(options)
      merge!(options)
    end

    def logfile=(filename)
      logger.warn '`logfile=` is deprecated, Please use `Syspay::SDK::Config.logger = Logger.new(STDERR)`'
    end

    def redirect_url=(redirect_url)
      logger.warn '`redirect_url=` is deprecated.'
    end

    def dev_central_url=(dev_central_url)
      logger.warn '`dev_central_url=` is deprecated.'
    end

    def ssl_options
      @ssl_options ||= {}.freeze
    end

    def ssl_options=(options)
      options = Hash[options.map{|key, value| [key.to_sym, value] }]
      @ssl_options = ssl_options.merge(options).freeze
    end

    def ca_file=(ca_file)
      logger.warn '`ca_file=` is deprecated, Please configure `ca_file=` under `ssl_options`'
      self.ssl_options = { :ca_file => ca_file }
    end

    def http_verify_mode=(verify_mode)
      logger.warn '`http_verify_mode=` is deprecated, Please configure `verify_mode=` under `ssl_options`'
      self.ssl_options = { :verify_mode => verify_mode }
    end

    def merge!(options)
      options.each do |key, value|
        send("#{key}=", value)
      end
      self
    end

    def required!(*names)
      names = names.select{|name| send(name).nil? }
      raise MissingConfig.new("Required configuration(#{names.join(", ")})") if names.any?
    end

    class << self

      @@config_cache = {}

      def load(file_name, default_env = default_environment)
        @@config_cache        = {}
        @@configurations      = read_configurations(file_name)
        @@default_environment = default_env
        config
      end

      def default_environment
        @@default_environment ||= ENV['SYSPAY_ENV'] || ENV['RACK_ENV'] || ENV['RAILS_ENV'] || "development"
      end

      def default_environment=(env)
        @@default_environment = env.to_s
      end

      def configure(options = {}, &block)
        begin
          self.config.merge!(options)
        rescue Errno::ENOENT
          self.configurations = { default_environment => options }
        end
        block.call(self.config) if block
        self.config
      end
      alias_method :set_config, :configure

      def config(env = default_environment, override_configuration = {})
        if env.is_a? Hash
          override_configuration = env
          env = default_environment
        end
        if override_configuration.nil? or override_configuration.empty?
          default_config(env)
        else
          default_config(env).dup.merge!(override_configuration)
        end
      end

      def default_config(env = nil)
        env = (env || default_environment).to_s
        if configurations[env]
          @@config_cache[env] ||= new(configurations[env])
        else
          raise Exceptions::MissingConfig.new("Configuration[#{env}] NotFound")
        end
      end

      def logger=(logger)
        Logging.logger = logger
      end

      def logger
        Logging.logger
      end

      def configurations
        @@configurations ||= read_configurations
      end

      def configurations=(configs)
        @@config_cache   = {}
        @@configurations = configs && Hash[configs.map{|k,v| [k.to_s, v] }]
      end

      private

      def read_configurations(file_name = "config/syspay.yml")
        erb = ERB.new(File.read(file_name))
        erb.filename = file_name
        YAML.load(erb.result)
      end
    end
  end
end