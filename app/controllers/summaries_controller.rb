class SummariesController < ApplicationController
  before_action :redirect_if_storage_unstarted
  after_action :suppress_browser_cache

  def show
    @form = Forms::Statement.new
    check_submission_form_error
  end

  private

  def check_submission_form_error
    @summary = Views::Summary.new(online_application)
    income_validation_check

    return unless flash['statement_blank']

    @form.errors.add(:signed_by, I18n.t('.confirmation.submission_statement_error'))
    flash.now['statement_blank'] = nil
  end

  def income_validation_check
    return unless @summary.income_validation_fails?

    flash.now[:error] = I18n.t('.summary.invalid_footer')
  end
end
