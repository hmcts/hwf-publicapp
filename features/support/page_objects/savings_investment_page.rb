class SavingsInvestmentPage < BasePage
  set_url '/questions/savings_and_investment'

  section :content, '#content' do
    element :step_info, '.govuk-caption-l', text: 'Step 7 of 22'
    element :header, 'h1', text: 'How much do you have in savings and investments?'
    element :married_reminder, 'span.govuk-hint', text: 'Remember to include your partner’s savings and investments in your total. For more information on what to include in your total see the Help section below.'
    element :hint_text, 'span.govuk-hint', text: 'For more information on what to include in your total see the Help section below.'
    element :low_amount, 'label', text: '£0 to £2,999'
    element :medium_amount, 'label', text: '£3,000 to £15,999'
    element :high_amount, 'label', text: '£16,000 or more'
    element :help_text, 'h2', text: 'What to include in savings and investments:'
  end

  def low_amount_checked
    savings_investment_page.content.low_amount.click
    continue
  end

  def medium_amount_checked
    savings_investment_page.content.medium_amount.click
    continue
  end

  def high_amount_checked
    savings_investment_page.content.high_amount.click
    continue
  end
end
