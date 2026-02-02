require 'rails_helper'

RSpec.describe SubmissionClient do
  let(:test_class) { Class.new { include SubmissionClient } }
  let(:instance) { test_class.new }

  describe '#submission_client_get' do
    let(:url) { 'http://example.com/test' }
    let(:status) { 200 }
    let(:body) { '{"ok":true}' }

    before { stub_request(:get, url).to_return(status: status, body: body) }

    it 'returns the response' do
      response = instance.submission_client_get(url)
      expect(response.code.to_i).to eq(200)
      expect(response.body).to eq(body)
    end
  end

  describe '#submission_client_post' do
    let(:url) { 'http://example.com/submit' }
    let(:params) { { name: 'test' } }
    let(:headers) { { 'Authorization' => 'Token token=ABC' } }

    before do
      stub_request(:post, url).to_return(status: 200, body: '{"result":"ok"}')
    end

    it 'returns the response' do
      response = instance.submission_client_post(url, params, headers)
      expect(response.code.to_i).to eq(200)
    end

    it 'sends the correct headers' do
      instance.submission_client_post(url, params, headers)
      expect(WebMock).to have_requested(:post, url).with(headers: headers)
    end

    it 'sends the form-encoded params' do
      instance.submission_client_post(url, params, headers)
      expect(WebMock).to have_requested(:post, url).with(body: hash_including('name' => 'test'))
    end
  end

  describe '#flatten_params' do
    it 'flattens a simple hash' do
      result = instance.flatten_params({ name: 'test', age: 30 })
      expect(result).to eq('name' => 'test', 'age' => '30')
    end

    it 'flattens nested hashes with bracket notation' do
      result = instance.flatten_params({ user: { name: 'test', married: true } })
      expect(result).to eq('user[name]' => 'test', 'user[married]' => 'true')
    end

    it 'flattens deeply nested hashes' do
      result = instance.flatten_params({ a: { b: { c: 'deep' } } })
      expect(result).to eq('a[b][c]' => 'deep')
    end

    it 'encodes arrays with bracket suffix' do
      result = instance.flatten_params({ tags: %w[one two] })
      expect(result).to eq('tags[]' => %w[one two])
    end

    it 'handles mixed nesting with arrays' do
      result = instance.flatten_params({ income_kind: { applicant: ['Wages'] } })
      expect(result).to eq('income_kind[applicant][]' => ['Wages'])
    end
  end
end
