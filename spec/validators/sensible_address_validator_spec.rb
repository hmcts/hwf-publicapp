require 'rails_helper'

class TestModel
  include ActiveModel::Validations

  def initialize(attributes = {})
    @attributes = attributes
  end

  def read_attribute_for_validation(key)
    @attributes[key]
  end
end

class TestSensibleAddress < TestModel
  validates :street, sensible_address: true
end

RSpec.describe SensibleAddressValidator do

  it "is valid for an input with no special characters" do
    expect(TestSensibleAddress.new(:street => 'name')).to be_valid

  end

  it "is valid for an input with some special characters" do
    expect(TestSensibleAddress.new(:street => "name,of-the'place")).to be_valid

  end

  it 'is not valid for an input with special characters' do
    expect(TestSensibleAddress.new(:street => 'qwe<@£$%^&*(')).not_to be_valid

  end

end
