class SubmissionsController < ApplicationController
  def create
    response = submit_service.post(online_application)
    storage.submission_result = response

    if response[:result]
      redirect_to(confirmation_route(online_application))
    else
      flash[:error] = I18n.t('.confirmation.submission_error')
      redirect_to(summary_path)
    end
  end

  def confirmation_route(online_application)
    if online_application.refund?
      refund_confirmation_path
    else
      confirmation_path
    end
  end

  private

  def submit_service
    @submit_service ||= SubmitApplication.new(Settings.submission.url, Settings.submission.token, params[:locale])
  end

end
