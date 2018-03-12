describe SyspaySDK::Checksum do
  let(:data) { 'foo' }
  let(:passphrase) { 'bar' }
  let(:checksum) { 'foobar' }

  describe '.get(data, passphrase)' do
    it 'returns a SHA1 digest of concatenated data and passphrase' do
      expect(Digest::SHA1).to receive(:hexdigest).with("#{data}#{passphrase}").and_return(checksum)

      expect(described_class.get(data, passphrase)).to eq(checksum)
    end
  end

  describe '.check' do
    it 'generates a SHA1 digest from data an passphrase then compares it to checksum' do
      expect(described_class).to receive(:get).with(data, passphrase).and_return(checksum)

      expect(described_class.check(data, passphrase, checksum)).to eq(true)

      expect(described_class).to receive(:get).with(data, passphrase).and_return('bar')

      expect(described_class.check(data, passphrase, checksum)).to eq(false)
    end
  end
end
