require 'rails_helper'

RSpec.describe SubmitApplication do
  subject(:submit_application) { described_class.new(url, token, locale) }

  let(:url) { 'http://api.example.com' }
  let(:token) { 'TOKEN' }
  let(:online_application) { build(:online_application) }
  let(:locale) { 'en' }

  describe '#available?' do
    subject { submit_application.available? }

    let(:request_path) { "#{url}/ping.json" }

    context 'when the connection is working' do
      before do
        stub_request(:get, request_path).to_return(status: status)
      end

      context 'when the response status is 200' do
        let(:status) { 200 }

        it { is_expected.to be true }
      end

      context 'when the response status is anything else than 200' do
        let(:status) { 500 }

        it { is_expected.to be false }
      end
    end

    context 'when the connection can not be established' do
      before do
        stub_request(:get, request_path).to_raise
      end

      it { is_expected.to be false }
    end
  end

  describe '#post' do
    subject(:post) { submit_application.post(online_application) }

    let(:response) { { 'result' => 'RESPONSE' } }
    let(:expected_response) { { result: 'RESPONSE' } }

    context 'welsh locale' do
      let(:locale) { 'cy' }

      describe 'when the request is valid' do
        before do
          stub_request(:post, "#{url}/api/submissions").
            with(body: hash_including({ "locale" => "cy" })).to_return(status: 200, body: response.to_json)
        end

        it 'returns the response with symbilised keys' do
          expect(subject).to eql(expected_response)
        end
      end
    end

    context 'english locale' do
      describe 'when the request is valid' do
        before do
          stub_request(:post, "#{url}/api/submissions").
            with(body: hash_including({ "locale" => "en" })).to_return(status: 200, body: response.to_json)
        end

        it 'returns the response with symbilised keys' do
          expect(subject).to eql(expected_response)
        end
      end
    end

    context 'when the response is not successful' do
      before do
        stub_request(:post, "#{url}/api/submissions").to_return(status: 422, body: '{"error":"invalid"}')
      end

      it 'raises an error' do
        expect { post }.to raise_error(SubmitApplication::SubmissionError)
      end
    end

    context 'when the connection fails' do
      before do
        stub_request(:post, "#{url}/api/submissions").to_raise(Errno::ECONNREFUSED)
      end

      it 'raises an error' do
        expect { post }.to raise_error(Errno::ECONNREFUSED)
      end
    end
  end
end
