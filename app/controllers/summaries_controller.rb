class SummariesController < ApplicationController
  before_action :redirect_if_storage_unstarted
  after_action :suppress_browser_cache

  def show
    @form = Forms::Statement.new
    check_submission_form_error
    @summary = Views::Summary.new(online_application)
  end

  private

  def check_submission_form_error
    return unless flash['statement_blank']

    @form.errors.add(:signed_by, I18n.t('.confirmation.submission_statement_error'))
    flash.now['statement_blank'] = nil
  end
end
