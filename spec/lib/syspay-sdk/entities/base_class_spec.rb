describe SyspaySDK::Entities::BaseClass do
  it 'responds to raw' do
    expect(subject).to respond_to(:raw)
  end

  it 'responds to #to_hash' do
    expect(subject).to respond_to(:to_hash)
  end

  it 'responds to type' do
    expect(subject).to respond_to(:type)
  end
end
