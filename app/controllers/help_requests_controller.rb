class HelpRequestsController < ApplicationController
  def new
    form
  end

  def create
    form.update_attributes(help_request_params)

    if form.valid?
      NotifyMailer.ask_for_help_email(form).deliver_now
      flash[:info] = I18n.t('help_requests.success')
      redirect_to(root_path)
    else
      render :new
    end
  end

  private

  def form
    @form ||= Forms::HelpRequest.new
  end

  def help_request_params
    params.require(form.id).permit(*form.permitted_attributes).to_h
  end
end
