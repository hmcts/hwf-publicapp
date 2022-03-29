class IncomeAmountPage < BasePage
  set_url '/questions/income_amount'

  section :content, '#content' do
    element :step_info, '.govuk-caption-l', text: 'Step 13 of 22'
    element :single_header, 'h1', text: 'What was your total income?'
    element :married_header, 'h1', text: 'What was your total income?'
    element :hint_text_single, 'p', text: 'Enter the total amount of income to the nearest pound you received in the full calendar month before you paid the fee.'
    element :hint_text_married, 'p', text: 'Enter the total amount of income to the nearest pound you and your partner received in the full calendar month before you paid the fee.'
    section :income_list, '.govuk-list' do
      elements :li, 'li'
    end
    element :income_amount, '#income_amount_amount'
    element :blank_error_link, 'a', text: 'Enter how much income do you receive'
  end

  def income(num)
    content.income_amount.set(num)
  end

end
