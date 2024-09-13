class SavingsInvestmentPage < BasePage
  include ActiveSupport::Testing::TimeHelpers
  set_url '/questions/savings_and_investment'

  section :content, '#content' do
    element :step_info, '.govuk-caption-l', text: 'Step 11 of 25'
    element :header, 'h1', text: 'Savings and Investments'
    element :married_reminder, 'div.govuk-hint', text: 'Remember to include your partner’s savings and investments in your total. For more information on what to include in your total see the Help section below.'
    element :hint_text, 'h2', text: 'How much did you have in savings and investments at the time you paid the fee?'
    element :married_reminder_ucd, 'div.govuk-hint', text: 'Tell us how much you and your partner have in savings and investments.'
    element :single_reminder, 'div.govuk-hint', text: 'Tell us how much you had in savings and investments at the time you paid the fee.'
    element :low_amount, 'label', text: 'Less than £4,250'
    element :medium_amount, 'label', text: 'Between £4,250 and £15,999'
    element :high_amount, 'label', text: '£16,000 or more'
    element :include_text, 'p', text: 'You should include:'
    element :help_text, 'h2', text: 'Don’t include the following in your savings total:'
  end

  def low_amount_checked
    savings_investment_page.content.low_amount.click
    continue
  end

  def medium_amount_checked
    savings_investment_page.content.medium_amount.click
    continue
  end

  def low_amount_checked_ucd
    savings_investment_page.content.low_amount.click
    continue
  end

  def medium_amount_checked_ucd
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

  def slowly_mid_amount_checked_ucd
    travel 61.minutes do
      savings_investment_page.content.medium_amount.click
      continue
    end
  end

  def slowly_low_amount_checked_ucd
    travel 61.minutes do
      savings_investment_page.content.low_amount.click
      continue
    end
  end
end
