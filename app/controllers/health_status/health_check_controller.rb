module HealthStatus
  class HealthCheckController < ApplicationController
    def show
      render json: { status: :ok }
      # health_check = HealthStatus::HealthCheck.new
      # render json: health_check, status: health_check.healthy? ? 200 : 500
    end
  end
end
