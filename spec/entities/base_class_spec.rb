require 'spec_helper'

describe SyspaySDK::Entities::BaseClass do
  it "responds to raw" do
    subject.should respond_to(:raw)
  end

  it "responds to to_hash" do
    subject.should respond_to(:to_hash)
  end

  it "raises an error when to_hash method is not implemented" do
    lambda do
      SyspaySDK::Entities::BaseClass.new.to_hash
    end.should raise_error(SyspaySDK::Exceptions::NotImplementedError)
  end

  it "responds to get_type" do
    subject.should respond_to(:get_type)
  end
end

# /**
#  * Base class for entities
#  */
# abstract class Syspay_Merchant_Entity
# {
#     /**
#      * An stdClass object representing the raw object returned by the API
#      *
#      * @var stdClass
#      */
#     public $raw;
#     /**
#      * Get an array representation of the object to build the request.
#      * It will collect all protected properties.
#      *
#      * @return array An array to be used in the request
#      */
#     public function toArray()
#     {
#         $data = array();
#         $r = new ReflectionClass($this);
#         $properties = $r->getProperties(ReflectionProperty::IS_PROTECTED);
#         foreach ($properties as $property) {
#             $name = $property->getName();
#             if (true === isset($this->$name)) {
#                 $data[$name] = $this->$name;
#             }
#         }
#         return $data;
#     }
#     /**
#      * Get the entity type
#      * @return string Entity type (as seen in the API)
#      */
#     public function getType()
#     {
#         // static:: has only been introduced as of PHP 5.3.
#         return constant(get_class($this) . '::TYPE');
#     }
# }