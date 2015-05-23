require 'spec_helper'

describe SyspaySDK::Entities::ReturnedEntity do
  describe "when included" do
    class ReturnedEntityInclusion
      include SyspaySDK::Entities::ReturnedEntity
    end

    it "raises an error when build_from_response method is not implemented" do
      lambda do
        ReturnedEntityInclusion.build_from_response({ test: "test" })
      end.should raise_error(SyspaySDK::Exceptions::NotImplementedError)
    end
  end
end