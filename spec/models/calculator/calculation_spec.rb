require 'rails_helper'

module Calculator
  RSpec.describe Calculation do
    context '#initialize' do
      it 'provides default values' do
        subject = described_class.new
        expect(subject).to have_attributes inputs: {},
                                           should_get_help: false,
                                           should_not_get_help: false,
                                           fields_required: [],
                                           required_fields_affecting_likelyhood: [],
                                           messages: [],
                                           fields: {}
      end
    end

    context '#inputs' do
      it 'stores a provided value of any type' do
        subject = described_class.new inputs: { any: :value }
        expect(subject.inputs).to eql(any: :value)
      end
    end

    context '#should_get_help' do
      it 'stores a provided value of any type' do
        subject = described_class.new should_get_help: true
        expect(subject.should_get_help).to be true
      end
    end

    context '#should_not_get_help' do
      it 'stores a provided value of any type' do
        subject = described_class.new should_not_get_help: true
        expect(subject.should_not_get_help).to be true
      end
    end

    context '#messages' do
      it 'stores a provided value of any type' do
        subject = described_class.new messages: [:any]
        expect(subject.messages).to eql [:any]
      end
    end

    context '#fields_required' do
      it 'stores a provided value of any type' do
        subject = described_class.new fields_required: [:any]
        expect(subject.fields_required).to eql [:any]
      end
    end

    context '#required_fields_affecting_likelyhood' do
      it 'stores a provided value of any type' do
        subject = described_class.new required_fields_affecting_likelyhood: [:any]
        expect(subject.required_fields_affecting_likelyhood).to eql [:any]
      end
    end

    context '#fields' do
      it 'stores a provided value of any type' do
        subject = described_class.new fields: { name: :any }
        expect(subject.fields).to eql(name: :any)
      end
    end

  end
end
