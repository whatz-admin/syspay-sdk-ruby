module SyspaySDK
  class Checksum
    class << self
      def get(data, passphrase)
        Digest::SHA1.digest("#{data}#{passphrase}");
      end

      def check(data, passphrase, checksum)
        get(data, passphrase) == checksum
      end
    end
  end
end
