class SubmitApplication
  include SubmissionClient

  class SubmissionError < StandardError; end

  def initialize(url, token, locale = 'en')
    @url = url
    @token = token
    @locale = locale
  end

  def available?
    response = submission_client_get("#{@url}/ping.json")
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
    submission_client_post("#{@url}/api/submissions",
                           build_params(online_application),
                           'Authorization' => "Token token=#{@token}")
  end

  def build_params(online_application)
    { online_application: online_application.as_json, locale: @locale }
  end
end
