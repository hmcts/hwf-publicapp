class ConfirmationsController < ApplicationController
  before_action :redirect_if_storage_unstarted
  after_action :suppress_browser_cache

  def show
    prepare_view
  end

  def create
    @online_application = online_application
    @result = storage.submission_result
    @form = Forms::ReferenceConfirm.new(form_params)

    if @form.valid?
      reset_cache
      redirect_to finish_session_path
    else
      error_and_template
    end
  end

  def refund
    prepare_view
  end

  private

  def prepare_view
    @online_application = online_application
    @result = storage.submission_result
    @form = Forms::ReferenceConfirm.new
  end

  def form_params
    params.require(:forms_reference_confirm).permit(:reference_confirm)
  rescue ActionController::ParameterMissing
    {}
  end

  def form_error_message
    method = @online_application.applying_method || 'refund'
    I18n.t(".confirmation.#{method}.confirmation_error")
  end

  def error_and_template
    @form.errors.clear
    flash.now[:error] = form_error_message
    @form.errors.add(:reference_confirm, form_error_message)

    if @online_application&.applying_method.nil? && @online_application.refund
      render :refund
    else
      render :show
    end
  end

  def reset_cache
    storage.clear
  end
end
