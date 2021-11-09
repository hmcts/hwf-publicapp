class MaritalStatusPage < BasePage
  set_url '/questions/marital_status'

  section :content, '#content' do
    element :step_info, '.govuk-caption-l', text: 'Step 6 of 22'
    element :header, 'h1', text: 'Are you single, married or living with someone and sharing an income?'
    element :single, 'label', text: 'Single'
    element :married, 'label', text: 'Married'
    element :help_choose_married, 'h2', text: 'Choose ‘married or living with someone'
    element :help_choose_single, 'h2', text: 'Choose ‘single’ if you rely on your own income'
    element :help_married, 'li', text: 'married'
    element :help_civil_partners, 'li', text: 'civil partners'
    element :help_living_together, 'li', text: 'living together as if you are married or in a civil partnership'
    element :help_same_address, 'li', text: 'living at the same address with a joint income'
    element :help_live_apart, 'li', text: 'a couple forced to live apart, eg where one or both'
    element :help_divorce, 'li', text: 'divorce, dissolution or annulment'
    element :help_gender, 'li', text: 'gender recognition'
    element :help_domestic_violence, 'li', text: 'domestic violence'
    element :help_forced_marriage, 'li', text: 'forced marriage'
    element :help_multiple_fee, 'li', text: 'you and your partner are both part of a multiple fee group'
  end

  def submit_single
    content.single.click
    continue
  end

  def submit_married
    content.married.click
    continue
  end

end
