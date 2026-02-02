require 'rails_helper'

module Forms
  class SomeQuestion < Forms::Base
    attribute :one, :string
    attribute :two, :boolean
  end
  RSpec.describe Base do

    # Because this is a base (abstract) class, I use a concrete model for testing the features
    subject(:model) { SomeQuestion.new }

    describe '#i18n_scope' do
      it 'returns the calling object name prefixed with "questions."' do
        expect(model.i18n_scope).to eql 'questions.some_question'
      end
    end

    %i[id to_param].each do |method_name|
      describe "##{method_name}" do
        it 'returns underscored string based on the class name' do
          expect(model.send(method_name)).to eql('some_question')
        end
      end
    end

    describe '#update_attributes' do
      before do
        model.update_attributes(one: 'ONE', two: true)
      end

      describe 'updates the attributes of the model' do
        it { expect(model.one).to eql('ONE') }
        it { expect(model.two).to be true }
      end
    end

    describe '#permitted_attributes' do
      it 'returns the list of all attributes from the model' do
        expect(model.permitted_attributes).to eql(%i[calculation_scheme one two])
      end
    end

    describe '#export' do
      subject(:export) { model.export }

      let(:params) { double }

      before do
        allow(model).to receive(:export_params).and_return(params)
      end

      it 'returns parameters from export_params method overriden by subclassing' do
        expect(subject).to eql(params)
      end
    end

    describe '#autocomplete' do
      before { allow(Rails).to receive(:env).and_return(ActiveSupport::StringInquirer.new(env)) }

      describe 'when in the development environment' do
        let(:env) { 'development' }

        it 'returns `yes`' do
          expect(model.autocomplete).to eql 'on'
        end
      end

      %w[production test].each do |environment|
        describe "when in the #{environment} environment" do
          let(:env) { environment }

          it 'returns `no`' do
            expect(model.autocomplete).to eql 'off'
          end
        end
      end
    end
  end
end
