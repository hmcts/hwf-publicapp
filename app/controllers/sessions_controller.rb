class SessionsController < ApplicationController
  # This is implemented as a GET method, because we won't have controll over
  # the page with the Start button that page will be managed by GOV.UK, so
  # we can't make it POST because of XSS restriction
  skip_before_action :verify_authenticity_token, only: :finish
  before_action :validate_app_id, only: [:destroy, :finish]

  def start
    app_id = SecureRandom.uuid
    Storage.new(session, app_id).start
    redirect_to(question_path(QuestionFormFactory.page_list.first, app_id: app_id))
  end

  def finish
    storage_with_clear
    redirect_path = Rails.application.config.finish_page_redirect_url || root_path
    redirect_to redirect_path, allow_other_host: true
  end

  def destroy
    storage_with_clear
    redirect_to(root_path)
  end

  private

  def storage_with_clear
    Storage.new(session, current_app_id, clear: true)
  end
end
