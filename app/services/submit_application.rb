require 'net/http'

class SubmitApplication
  class SubmissionError < StandardError; end

  def initialize(url, token, locale = 'en')
    @url = url
    @token = token
    @locale = locale
  end

  def available?
    uri = URI("#{@url}/ping.json")
    response = Net::HTTP.get_response(uri)
    response.code.to_i == 200
  rescue StandardError
    false
  end

  def post(online_application)
    response = post_data(online_application)
    raise SubmissionError, "HTTP #{response.code}: #{response.body}" unless response.is_a?(Net::HTTPSuccess)

    JSON.parse(response.body).deep_symbolize_keys
  end

  private

  def post_data(online_application)
    uri = URI("#{@url}/api/submissions")
    request = Net::HTTP::Post.new(uri)
    request['Authorization'] = "Token token=#{@token}"
    request.set_form_data(build_params(online_application))
    Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == 'https') { |http| http.request(request) }
  end

  def build_params(online_application)
    { online_application: online_application.as_json, locale: @locale }
  end
end
