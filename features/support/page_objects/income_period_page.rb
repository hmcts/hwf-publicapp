class IncomePeriodPage < BasePage
  set_url '/questions/income_period'

  section :content, '#content' do
    element :step_info, '.govuk-caption-l', text: 'Step 13 of 22'
    element :single_header, 'h1', text: 'How much income did you receive?'
    element :income_amount, '#income_period_amount'
    element :blank_error_link, 'a', text: 'Enter how much income do you receive'
  end

  def income(num)
    content.income_amount.set(num)
  end

end
