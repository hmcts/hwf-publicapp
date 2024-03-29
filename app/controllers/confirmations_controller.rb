class ConfirmationsController < ApplicationController
  before_action :redirect_if_storage_unstarted
  after_action :suppress_browser_cache
  after_action :reset_cache

  def show
    prepare_view
  end

  def refund
    prepare_view
  end

  private

  def prepare_view
    @online_application = online_application
    @result = storage.submission_result
  end

  def reset_cache
    storage.clear
  end
end
