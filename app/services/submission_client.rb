require 'net/http'

module SubmissionClient
  def submission_client_get(url)
    uri = URI(url)
    Net::HTTP.get_response(uri)
  end

  def submission_client_post(url, params, headers = {})
    uri = URI(url)
    request = Net::HTTP::Post.new(uri)
    headers.each { |key, value| request[key] = value }
    request.set_form_data(flatten_params(params))
    Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == 'https') { |http| http.request(request) }
  end

  # Recursively flattens nested hashes into bracket-notated keys for form encoding,
  # replicating the behaviour RestClient performed automatically.
  # e.g. { user: { name: "Jo" } } => { "user[name]" => "Jo" }
  def flatten_params(params, prefix = nil)
    params.each_with_object({}) do |(key, value), result|
      full_key = prefix ? "#{prefix}[#{key}]" : key.to_s
      case value
      when Hash then result.merge!(flatten_params(value, full_key))
      when Array then result["#{full_key}[]"] = value.map(&:to_s)
      else result[full_key] = value.to_s
      end
    end
  end
end
