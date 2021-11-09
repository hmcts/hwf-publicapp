class IncomeRangePage < BasePage
  set_url '/questions/income_range'

  section :content, '#content' do
    element :step_info, '.govuk-caption-l', text: 'Step 12 of 22'
    element :single_header, 'h1', text: 'How much income did you receive each month?'
    element :married_header, 'h1', text: 'How much income do you and your partner receive each month?'
    element :select_single_income_hint, 'p', text: 'Select the monthly amount you received in income from:'
    element :select_married_income_hint, 'p', text: 'Select the monthly amount you and your partner receive in income from: Wages If your income varies from month to month, work out an average monthly income based on the last 3 months.'
    element :choose_income_single, 'p', text: 'Choose the different types of income you receive.'
    element :choose_income_married, 'p', text: 'Choose the different types of income you and your partner receive.'
    elements :income_label, 'label'
    elements :input, 'label input'
    elements :income, 'li'
    element :blank_error_link, 'a', text: 'Select your monthly income'
    element :income_range_less, '.govuk-label', text: 'Less than'
    element :income_range_between, '.govuk-label', text: 'Between'
    element :income_range_more, '.govuk-label', text: 'More than'
  end

  def submit_less
    content.income_range_less.click
    continue
  end

  def submit_between
    content.income_range_between.click
    continue
  end

  def submit_more
    content.income_range_more.click
    continue
  end
end
