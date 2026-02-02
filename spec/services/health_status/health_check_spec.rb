require 'rails_helper'

RSpec.describe HealthStatus::HealthCheck, type: :service do
  subject(:service) { described_class.new }

  let(:submit_application) { double(available?: submit_application_available?) }
  let(:downstream_api) { double(available?: downstream_api_ok?) }
  let(:downstream_api_ok?) { true }
  let(:json_returned) { "{\"database\":{\"description\":\"Postgres database\",\"ok\":true},\"ok\":#{downstream_api_ok?}}" }

  before do
    stub_request(:get, "http://submit.to.this/healthcheck.json").
      to_return(status: downstream_api_ok? ? 200 : 500, body: json_returned, headers: {})
    allow(SubmitApplication).to receive(:new).and_return(submit_application)
  end

  describe '#as_json' do
    subject { service.as_json }

    context 'when there are no issues with the downstream health check' do
      context 'when the submission api is available' do
        let(:submit_application_available?) { true }

        it 'returns hash with all services ok' do
          expect(subject).to eql(
            submission_api: {
              description: 'Submission API',
              ok: true
            },
            downstream_api_ok: {
              description: 'Downstream API',
              ok: true
            },
            ok: true
          )
        end
      end

      context 'when the submission api is not available' do
        let(:submit_application_available?) { false }

        it 'returns hash with services unavailable' do
          expect(subject).to eql(
            submission_api: {
              description: 'Submission API',
              ok: false
            },
            downstream_api_ok: {
              description: 'Downstream API',
              ok: true
            },
            ok: false
          )
        end
      end
    end

    context 'when there are issues with the downstream health check' do
      let(:downstream_api_ok?) { false }

      context 'when the submission api is available' do
        let(:submit_application_available?) { true }

        it 'returns hash with all services ok' do
          expect(subject).to eql(
            submission_api: {
              description: 'Submission API',
              ok: true
            },
            downstream_api_ok: {
              description: 'Downstream API',
              ok: false
            },
            ok: false
          )
        end
      end

      context 'when the submission api is not available' do
        let(:submit_application_available?) { false }

        it 'returns hash with services unavailable' do
          expect(subject).to eql(
            submission_api: {
              description: 'Submission API',
              ok: false
            },
            downstream_api_ok: {
              description: 'Downstream API',
              ok: false
            },
            ok: false
          )
        end
      end
    end

    context 'when the downstream health check connection fails' do
      let(:submit_application_available?) { true }

      before do
        stub_request(:get, "http://submit.to.this/healthcheck.json").to_raise(Errno::ECONNREFUSED)
        allow(SubmitApplication).to receive(:new).and_return(submit_application)
      end

      it 'returns downstream_api_ok as false' do
        expect(subject).to eql(
          submission_api: {
            description: 'Submission API',
            ok: true
          },
          downstream_api_ok: {
            description: 'Downstream API',
            ok: false
          },
          ok: false
        )
      end
    end
  end

  describe '#healthy?' do
    subject { service.healthy? }

    context 'when the submission api is available' do
      let(:submit_application_available?) { true }

      it { is_expected.to be true }
    end

    context 'when the submission api is not available' do
      let(:submit_application_available?) { false }

      it { is_expected.to be false }
    end
  end
end
