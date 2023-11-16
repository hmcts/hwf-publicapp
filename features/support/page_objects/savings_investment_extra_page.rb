class SavingsInvestmentExtraPage < BasePage
  include ActiveSupport::Testing::TimeHelpers
  set_url '/questions/savings_and_investment_extra'

  section :content, '#content' do
    element :step_info, '.govuk-caption-l', text: 'Step 8 of 22'
    element :single_header, 'h1', text: 'Are you 66 years or older?'
    element :married_header, 'h1', text: 'Are you or your partner 66 or older?'
    element :yes, 'label', text: 'Yes'
    element :no, 'label', text: 'No'
    element :how_much_label_single, '.govuk-label', text: 'How much between £3,000 and £15,999 do you have in savings and investments?'
    element :how_much_label_married, '.govuk-label', text: 'How much between £3,000 and £15,999 do you and your partner have in savings and investments?'
    element :extra_amount, '#savings_and_investment_extra_amount'
    element :error_link, 'a', text: 'Enter an amount between £3,000 and £15,999, or go back to the previous question about your savings'
    element :blank_error_link, 'a', text: 'Enter how much you have in savings and investments'
  end

  def submit_yes
    content.yes.click
    continue
  end

  def submit_no
    content.no.click
    continue
  end

  def slowly_submit_yes
    travel 61.minutes do
      content.yes.click
      continue
    end
  end

  def slowly_submit_no
    travel 61.minutes do
      content.no.click
      continue
    end
  end
end
