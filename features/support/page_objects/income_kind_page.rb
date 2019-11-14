class IncomeKindPage < BasePage
  set_url '/questions/income_kind'

  section :content, '#content' do
    element :step_info, '.govuk-caption-l', text: 'Step 8 of 20'
    element :income_kind_header_single, 'h1', text: 'What kind of income did you receive?'
    element :income_kind_header_married, 'h1', text: 'What kind of income did you and your partner receive?'
    element :choose_income_single, 'p', text: 'Choose the different types of income you received at the time you paid the fee.'
    element :choose_income_married, 'p', text: 'Choose the different types of income you and your partner received at the time you paid the fee.'
    element :your_income, 'h3', text: 'Your income'
    element :wages, 'label', text: 'Wages'
    element :no_income, 'label', text: 'No income'
    element :working_tax_credit, 'label', text: 'Working Tax Credit'
    element :partners_income, 'h3', text: 'Your partner\'s income'
    elements :income_label, 'label'
    elements :input, 'label input'
    element :blank_error_link, 'a', text: 'Select your kinds of income'
    element :blank_error_message, '.error-message', text: 'Select your kinds of income'
  end

  def to_income_kind_single
    form_name_page.to_form_name
    form_name_page.submit_valid_form_number
    fee_page.submit_fee_yes
    marital_status_page.submit_single
    savings_investment_page.high_amount_checked
    benefit_page.submit_benefit_no
    dependent_page.submit_dependent_3
  end

  def to_income_kind_married
    form_name_page.to_form_name
    form_name_page.submit_valid_form_number
    fee_page.submit_fee_yes
    marital_status_page.submit_married
    savings_investment_page.high_amount_checked
    benefit_page.submit_benefit_no
    dependent_page.submit_dependent_3
  end

  def submit_no_income
    content.no_income.click
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
end
