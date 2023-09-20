module AddressLookup
  class << self
    def access_token(question)
      return if question != :applicant_address

      Rails.cache.fetch('address_lookup', expires_in: 290) do
        uri = URI(Rails.configuration.x.address_lookup.endpoint)
        set_authentication
        lookup_request(uri)
      end
    end

    private

    def set_authentication
      @request = Net::HTTP::Post.new('/oauth2/token/v1')
      @request.basic_auth(
        Rails.configuration.x.address_lookup.api_key,
        Rails.configuration.x.address_lookup.api_secret
      )
      @request.set_form_data('grant_type' => 'client_credentials')
    end

    def lookup_request(uri)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = uri.instance_of? URI::HTTPS
      begin
        response = http.request(@request)
        parse_response(response)
      rescue StandardError => e
        Rails.logger.error("Address Lookup Fetch Access Token error: #{e}")
        nil
      end
    end

    def parse_response(response)
      if response.is_a?(Net::HTTPSuccess)
        JSON.parse(response.body).fetch('access_token', nil).tap do |token|
          Rails.logger.info("[Address Lookup] :: os cred #{response.body} -- token: #{token}")
        end
      end
    end
  end
end
