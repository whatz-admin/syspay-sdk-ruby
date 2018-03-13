# frozen_string_literal: true

module SyspaySDK
  class EMS
    CODE_INVALID_MERCHANT = 0
    CODE_INVALID_CHECKSUM = 1
    CODE_INVALID_CONTENT  = 2
    EVENT_ID_HEADER = 'X-Event-Id'
    EVENT_DATE_HEADER = 'X-Event-Date'
    CHECKSUM_HEADER = 'X-Checksum'
    MERCHANT_HEADER = 'X-Merchant'

    attr_reader :id, :date

    def initialize(id:, date:, checksum:, merchant:, type:, data:, skip_checksum: false)
      raise SyspaySDK::Exceptions::EMSError.new('Missing merchant', CODE_INVALID_MERCHANT) if merchant.nil?
      raise SyspaySDK::Exceptions::EMSError.new('Invalid merchant', CODE_INVALID_MERCHANT) if merchant != SyspaySDK::Config.config.syspay_id
      raise SyspaySDK::Exceptions::EMSError.new('Invalid checksum', CODE_INVALID_CHECKSUM) if checksum.nil?

      @id = id
      @date = Time.at(date)
      @checksum = checksum
      @merchant = merchant
      @type = type
      @data = data
      @skip_checksum = skip_checksum

      @passphrase = SyspaySDK::Config.config.syspay_passphrase
    end

    def verify!
      return if SyspaySDK::Checksum.check(@data, @passphrase, @checksum)

      raise SyspaySDK::Exceptions::EMSError.new('Invalid checksum', CODE_INVALID_CHECKSUM)
    end

    def entity
      verify! unless @skip_checksum

      raise SyspaySDK::Exceptions::EMSError.new('Unable to get event type', CODE_INVALID_CONTENT) if @type.nil?
      raise SyspaySDK::Exceptions::EMSError.new('Unable to get data from content', CODE_INVALID_CONTENT) if @data.nil?

      case @type
      when 'payment'
        raise SyspaySDK::Exceptions::EMSError.new('Payment event received with no payment data', CODE_INVALID_CONTENT) if @data[:payment].nil?

        SyspaySDK::Entities::Payment.build_from_response(@data[:payment])
      when 'refund'
        raise SyspaySDK::Exceptions::EMSError.new('Refund event received with no refund data', CODE_INVALID_CONTENT) if @data[:refund].nil?

        SyspaySDK::Entities::Refund.build_from_response(@data[:refund])
      when 'chargeback'
        raise SyspaySDK::Exceptions::EMSError.new('Chargeback event received with no chargeback data', CODE_INVALID_CONTENT) if @data[:chargeback].nil?

        SyspaySDK::Entities::Chargeback.build_from_response(@data[:chargeback])
      when 'billing_agreement'
        raise SyspaySDK::Exceptions::EMSError.new('BillingAgreement event received with no billing_agreement data', CODE_INVALID_CONTENT) if @data[:billing_agreement].nil?

        SyspaySDK::Entities::BillingAgreement.build_from_response(@data[:billing_agreement])
      when 'subscription'
        raise SyspaySDK::Exceptions::EMSError.new('Subscription event received with no subscription data', CODE_INVALID_CONTENT) if @data[:subscription].nil?

        SyspaySDK::Entities::Subscription.build_from_response(@data[:subscription])
      else
        raise SyspaySDK::Exceptions::EMSError.new("Unknown type : #{@type}", CODE_INVALID_CONTENT)
      end
    end
  end
end
