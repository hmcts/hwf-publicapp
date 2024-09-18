class IncomeKindPage < BasePage
  include ActiveSupport::Testing::TimeHelpers
  set_url '/questions/income_kind'

  section :content, '#content' do
    element :step_info, '.govuk-caption-l', text: 'Step 11 of 22'
    element :step_info_ucd, '.govuk-caption-l', text: 'Step 15 of 22'
    element :single_header, 'h1', text: 'What kind of income did you receive?'
    element :married_header, 'h1', text: 'What kind of income do you and your partner receive?'
    element :choose_income_single, 'div.govuk-hint', text: 'Select all the different types of income you received in the full calendar month before you paid the fee.'
    element :choose_income_married, 'div.govuk-hint', text: 'Select all the different types of income you and your partner received in the full calendar month before you paid your fee.'
    element :single_header_ucd, 'h1', text: 'Types of income you have received'
    element :married_header_ucd, 'h1', text: 'Types of income you and your partner have received'
    element :choose_income_single_ucd, 'div.govuk-hint', text: 'Tick all the types of income you have received in the last calendar month'
    element :choose_income_married_ucd, 'div.govuk-hint', text: 'Tick all the types of income you and your partner have received in the last calendar month'
    element :representative_hint_single, 'div.govuk-hint', text: 'If your income last month is not representative of what you usually get, you can provide an average income for the last 3 months if this is lower. If so, tick all income types for that period.'
    element :representative_hint_married, 'div.govuk-hint', text: "If you and your partner's income last month is not representative of what you usually get, you can provide an average income for the last 3 months if this is lower. If so, tick all income types for that period."
    element :your_income, 'h2', text: 'Your income'
    element :partners_income, 'h2', text: 'Your partner\'s income'
    element :wages, 'label', text: 'Wages'
    element :none_of_the_above, 'label', text: 'None of the above'
    element :none_of_the_above_partner, 'label[for="income_kind_partner_17"]'
    element :no_income, 'label', text: 'No income'
    element :working_tax_credit, 'label', text: 'Working Tax Credit'
    elements :income_item, '.govuk-checkboxes__item'
    element :blank_error_link, 'a', text: 'Select your kinds of income'
  end

  def submit_no_income
    content.no_income.click
    continue
  end

  def submit_none_of_the_above
    content.none_of_the_above.click
    continue
  end

  def submit_none_of_the_above_married
    content.none_of_the_above.click
    content.none_of_the_above_partner.click
    continue
  end

  def submit_single_income_wages_tax_credit
    content.wages.click
    content.working_tax_credit.click
    continue
  end

  def submit_married_income_wages_tax_credit
    content.wages.click
    content.working_tax_credit.click
    continue
  end

  def slowly_submit_single_income_wages_tax_credit
    travel 61.minutes do
      content.wages.click
      content.working_tax_credit.click
      continue
    end
  end
end
