class SubmissionsController < ApplicationController
  def create
    statement_check
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

  def submit
    response = submit_service.post(online_application)
    storage.submission_result = response

    if response[:result]
      redirect_to(confirmation_route(online_application))
    else
      flash[:error] = I18n.t('.confirmation.submission_error')
      redirect_to(summary_path)
    end
  end

  def statement_params
    params.require(@form.id).permit(@form.permitted_attributes).to_h
  rescue ActionController::ParameterMissing
    @form_error = I18n.t('.confirmation.submission_statement_error')
    {}
  end

  def statement_check
    @form = Forms::Statement.new

    @form.update_attributes(statement_params)
    if @form.valid?
      save_statement_form
      submit
    else
      flash[:error] = @form_error || I18n.t('.confirmation.submission_error')
      flash[:statement_blank] = true
      redirect_to(summary_path)
    end
  end

  def save_statement_form
    storage.save_form(@form)
    online_application.statement_signed_by = @form.signed_by
  end
end
