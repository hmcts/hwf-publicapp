module HealthStatus
  class HealthCheck
    def initialize
      check_submission_api!
      downstream_api_ok?
    end

    def as_json(_options = {}) # rubocop:disable Metrics/MethodLength
      {
        submission_api: {
          description: 'Submission API',
          ok: @submission_api_available
        },
        downstream_api_ok: {
          description: 'Downstream API',
          ok: @downstream_api_ok
        },
        ok: @submission_api_available && @downstream_api_ok
      }
    end

    def healthy?
      @submission_api_available
    end

    private

    def check_submission_api!
      service = SubmitApplication.new(Settings.submission.url, Settings.submission.token)
      @submission_api_available = service.available?
    end

    def downstream_api_ok?
      @downstream_api_ok = staff_app_health_check_result
    end

    def staff_app_health_check_result
      uri = URI("#{Settings.submission.url}/healthcheck.json")
      response = Net::HTTP.get_response(uri)
      json = JSON.parse(response.body)
      json['ok']
    rescue StandardError
      false
    end
  end
end
