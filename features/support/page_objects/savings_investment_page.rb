class SavingsInvestmentPage < BasePage
  include ActiveSupport::Testing::TimeHelpers
  set_url '/questions/savings_and_investment'

  section :content, '#content' do
    element :step_info, '.govuk-caption-l', text: 'Step 7 of 22'
    element :step_info_ucd, '.govuk-caption-l', text: 'Step 11 of 22'
    element :header, 'h1', text: 'How much did you have in savings and investments at the time you paid the fee?'
    element :married_reminder, 'div.govuk-hint', text: 'Remember to include your partner’s savings and investments in your total. For more information on what to include in your total see the Help section below.'
    element :hint_text, 'div.govuk-hint', text: 'To the nearest pound, select from the options below how much you had in savings and investments at the time you paid the fee. For more information on what to include in your total see the help section below.'
    element :header_ucd, 'h1', text: 'Savings and Investments'
    element :married_reminder_ucd, 'div.govuk-hint', text: 'Tell us how much you and your partner have in savings and investments.'
    element :single_reminder, 'div.govuk-hint', text: 'Tell us how much you had in savings and investments at the time you paid the fee.'
    element :low_amount, 'label', text: '£0 to £2,999'
    element :medium_amount, 'label', text: '£3,000 to £15,999'
    element :low_amount_ucd, 'label', text: 'Less than £4,250'
    element :medium_amount_ucd, 'label', text: 'Between £4,250 and £15,999'
    element :high_amount, 'label', text: '£16,000 or more'
    element :include_text, 'p', text: 'You should include:'
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

  def low_amount_checked_ucd
    savings_investment_page.content.low_amount_ucd.click
    continue
  end

  def medium_amount_checked_ucd
    savings_investment_page.content.medium_amount_ucd.click
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
      savings_investment_page.content.medium_amount_ucd.click
      continue
    end
  end

  def slowly_low_amount_checked_ucd
    travel 61.minutes do
      savings_investment_page.content.low_amount_ucd.click
      continue
    end
  end
end
