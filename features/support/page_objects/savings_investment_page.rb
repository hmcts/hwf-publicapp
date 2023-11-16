class SavingsInvestmentPage < BasePage
  include ActiveSupport::Testing::TimeHelpers
  set_url '/questions/savings_and_investment'

  section :content, '#content' do
    element :step_info, '.govuk-caption-l', text: 'Step 7 of 22'
    element :header, 'h1', text: 'Saving and Investments'
    element :married_reminder, 'div.govuk-hint', text: 'Tell us how much you and your partner have in savings and investments.'
    element :single_reminder, 'div.govuk-hint', text: 'Tell us how much you had in savings and investments at the time you paid the fee.'
    element :low_amount, 'label', text: '£0 to £2,999'
    element :medium_amount, 'label', text: '£3,000 to £15,999'
    element :high_amount, 'label', text: '£16,000 or more'
    element :include_text, 'p', text: 'You should include:'
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

  def slowly_high_amount_checked
    travel 61.minutes do
      savings_investment_page.content.high_amount.click
      continue
    end
  end

  def slowly_mid_amount_checked
    travel 61.minutes do
      savings_investment_page.content.medium_amount.click
      continue
    end
  end

  def slowly_low_amount_checked
    travel 61.minutes do
      savings_investment_page.content.low_amount.click
      continue
    end
  end
end
