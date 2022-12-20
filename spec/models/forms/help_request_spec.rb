require 'rails_helper'

RSpec.describe Forms::HelpRequest do
  subject { described_class.new }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_presence_of(:description) }
end
