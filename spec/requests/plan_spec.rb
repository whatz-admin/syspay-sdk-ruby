require 'spec_helper'

describe SyspaySDK::Requests::Plan do
  it "is a SyspaySDK::Requests::BaseClass" do
    subject.should be_a(SyspaySDK::Requests::BaseClass)
  end

  describe "Constants" do
    it "has a METHOD class constant set to 'POST'" do
      SyspaySDK::Requests::Plan::METHOD.should eq('POST')
    end

    it "has a PATH class constant set to '/api/v1/merchant/plan'" do
      SyspaySDK::Requests::Plan::PATH.should eq('/api/v1/merchant/plan')
    end
  end

  describe "Attributes" do
    it { should respond_to(:plan) }
  end

  it { should respond_to(:get_method) }

  describe "#get_method" do
    it "returns the METHOD constant" do
      subject.get_method.should eq(SyspaySDK::Requests::Plan::METHOD)
    end
  end

  it { should respond_to(:get_path) }

  describe "#get_path" do
    it "returns the PATH constant" do
      subject.get_path.should eq(SyspaySDK::Requests::Plan::PATH)
    end
  end

  it { should respond_to(:build_response) }

  describe "#build_response" do
    it "raises a SyspaySDK::Exceptions::BadArgumentTypeError when anything but a hash is passed in" do
      lambda do
        subject.build_response("test")
      end.should raise_error(SyspaySDK::Exceptions::BadArgumentTypeError)
    end

    it "raises a SyspaySDK::Exceptions::UnexpectedResponseError the hash doesn't contain the plan" do
      lambda do
        subject.build_response({test: "test"})
      end.should raise_error(SyspaySDK::Exceptions::UnexpectedResponseError)
    end

    it "returns an SyspaySDK::Entities::Plan" do
      subject.build_response({ plan: {} }).should be_a(SyspaySDK::Entities::Plan)
    end
  end

  it { should respond_to(:get_data) }

  describe "#get_data" do
    it "returns a hash" do
      subject.get_data.should be_a(Hash)
    end

    it "returns the plan as a hash" do
      subject.plan = SyspaySDK::Entities::Plan.new
      subject.get_data.should eq(subject.plan.to_hash)
    end
  end
end
# <?php
# /**
#  * Create a plan
#  * @see https://app.syspay.com/docs/api/merchant_subscription.html#create-a-plan
#  */
# class Syspay_Merchant_PlanRequest extends Syspay_Merchant_Request
# {
#     const METHOD = 'POST';
#     const PATH   = '/api/v1/merchant/plan';
#     /**
#      * @var Syspay_Merchant_Entity_Plan
#      */
#     private $plan;
#     /**
#      * {@inheritDoc}
#      */
#     public function getMethod()
#     {
#         return self::METHOD;
#     }
#     /**
#      * {@inheritDoc}
#      */
#     public function getPath()
#     {
#         return self::PATH;
#     }
#     /**
#      * {@inheritDoc}
#      */
#     public function buildResponse(stdClass $response)
#     {
#         if (!isset($response->plan)) {
#             throw new Syspay_Merchant_UnexpectedResponseException(
#                 'Unable to retrive "plan" data from response',
#                 $response
#             );
#         }
#         $plan = Syspay_Merchant_Entity_Plan::buildFromResponse($response->plan);
#         return $plan;
#     }
#     /**
#      * {@inheritDoc}
#      */
#     public function getData()
#     {
#         $data = array();
#         if (false === empty($this->plan)) {
#             $data = $this->plan->toArray();
#         }
#         return $data;
#     }
#     /**
#      * Gets the value of plan.
#      *
#      * @return Syspay_Merchant_Entity_Plan
#      */
#     public function getPlan()
#     {
#         return $this->plan;
#     }
#     /**
#      * Sets the value of plan.
#      *
#      * @param Syspay_Merchant_Entity_Plan $plan the plan
#      *
#      * @return self
#      */
#     public function setPlan(Syspay_Merchant_Entity_Plan $plan)
#     {
#         $this->plan = $plan;
#         return $this;
#     }
# }