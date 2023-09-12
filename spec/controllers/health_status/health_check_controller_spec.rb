require 'rails_helper'

RSpec.describe HealthStatus::HealthCheckController do
  describe '#show' do
    let(:json) { { status: 'ok' } }
    let(:health_check) { instance_double(HealthStatus::HealthCheck, as_json: json, healthy?: healthy?) }

    before do
      allow(HealthStatus::HealthCheck).to receive(:new).and_return(health_check)

      get :show
    end

    context 'when the health check reports as healthy' do
      let(:healthy?) { true }

      it 'responds with 200 status' do
        expect(response).to have_http_status(:ok)
      end

      it 'renders the health check json' do
        expect(response.body).to eql(json.to_json)
      end
    end

    # context 'when the health check reports as unhealthy' do
    #   let(:healthy?) { false }

    #   it 'responds with 500 status' do
    #     expect(response).to have_http_status(:internal_server_error)
    #   end

    #   it 'renders the health check json' do
    #     expect(response.body).to eql(json.to_json)
    #   end
    # end
  end
end
