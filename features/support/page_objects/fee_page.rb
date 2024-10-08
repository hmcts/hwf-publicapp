class FeePage < BasePage
  include ActiveSupport::Testing::TimeHelpers
  set_url '/questions/fee'

  section :content, '#content' do
    element :step_info, '.govuk-caption-l', text: 'Step 1 of 25'
    element :header, 'h1', text: 'Have you already paid the court or tribunal fee?'
    element :apply_for_refund, '.govuk-body', text: 'You can apply for a refund for a fee paid in the last 3 months'
    element :format_error_link, 'a', text: 'Enter the date in this format DD/MM/YYYY'
    element :format_error_message, '.error-message', text: 'Enter the date in this format DD/MM/YYYY'
    element :expired_error_link, 'a', text: 'The date the fee was paid must have been within the last three months'
    element :expired_error_message, '.error-message', text: 'The date the fee was paid must have been within the last three months'
    element :future_date_error_link, 'a', text: 'This date can\'t be in the future'
    element :future_date_error_message, '.error-message', text: 'This date can\'t be in the future'
    element :blank_error_link, 'a', text: 'Select whether you\'ve already paid the fee'
    element :no, 'label', text: 'No'
    element :yes, 'label', text: 'Yes'
    element :use_this_date, '.hint', text: 'For example, 04 10 2018'
    element :fee_day_date_paid, '#fee_day_date_paid'
    element :fee_month_date_paid, '#fee_month_date_paid'
    element :fee_year_date_paid, '#fee_year_date_paid'
    element :date_fee_paid, '.govuk-label', text: 'Date fee paid'
  end

  def expired_date
    date = Time.zone.today - 4.months
    content.fee_day_date_paid.set(date.day)
    content.fee_month_date_paid.set(date.month)
    content.fee_year_date_paid.set(date.year)
    continue
  end

  def future_date
    date = Time.zone.today + 1.month
    content.fee_day_date_paid.set(date.day)
    content.fee_month_date_paid.set(date.month)
    content.fee_year_date_paid.set(date.year)
    continue
  end

  def valid_date
    date = Time.zone.today - 1.month
    content.fee_day_date_paid.set(date.day)
    content.fee_month_date_paid.set(date.month)
    content.fee_year_date_paid.set(date.year)
    continue
  end

  def submit_fee_yes
    date = Time.zone.today - 1.month
    content.yes.click
    content.fee_day_date_paid.set(date.day)
    content.fee_month_date_paid.set(date.month)
    content.fee_year_date_paid.set(date.year)
    continue
  end

  def submit_fee_no
    content.no.click
    continue
  end

  def slow_valid_date
    travel 61.minutes do
      date = Time.zone.today - 1.month
      content.fee_day_date_paid.set(date.day)
      content.fee_month_date_paid.set(date.month)
      content.fee_year_date_paid.set(date.year)
      continue
    end
  end

  def invalid_date
    content.fee_day_date_paid.set("ABC")
    content.fee_month_date_paid.set("ABC")
    content.fee_year_date_paid.set("ABC")
    continue
  end

  def slow_no
    travel 61.minutes do
      submit_fee_no
    end
  end
end
