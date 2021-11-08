class FeePage < BasePage
  set_url '/questions/fee'

  section :content, '#content' do
    element :step_info, '.govuk-caption-l', text: 'Step 2 of 22'
    element :header, 'h1', text: 'Have you already paid the fee?'
    element :apply_for_refund, '.govuk-body', text: 'You can apply for a refund for a fee paid in the last 3 months'
    element :format_error_link, 'a', text: 'Enter the date in this format DD/MM/YYYY'
    element :format_error_message, '.error-message', text: 'Enter the date in this format DD/MM/YYYY'
    element :expired_error_link, 'a', text: 'The application must have been made in the last 3 months'
    element :expired_error_message, '.error-message', text: 'The application must have been made in the last 3 months'
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
end
