class MaritalStatusPage < BasePage
  set_url '/questions/marital_status'

  section :content, '#content' do
    element :step_info, '.govuk-caption-l', text: 'Step 6 of 22'
    element :header, 'h1', text: 'Are you single, married or living with someone and sharing an income?'
    element :single, 'label', text: 'Single'
    element :married, 'label', text: 'Married'
    element :help_choose_married, 'h2', text: 'Select ‘Married or living with someone and sharing an income’ if you’re:'
    element :help_choose_single, 'h2', text: 'Select ‘Single’ if you rely on your own income or your case involves your partner, for example:'
    element :help_married, 'li', text: 'married'
    element :help_civil_partners, 'li', text: 'civil partners'
    element :help_living_together, 'li', text: 'living together as if you are married or in a civil partnership'
    element :help_same_address, 'li', text: 'living at the same address with a joint income'
    element :help_live_apart, 'li', text: 'a couple forced to live apart, eg where one or both'
    element :help_divorce, 'li', text: 'divorced or applying for a divorce and you are not living with a new partner'
    element :help_dissolution, 'li', text: 'dissolution or annulment and you are not living with a new partner'
    element :help_gender, 'li', text: 'gender recognition'
    element :help_domestic_violence, 'li', text: 'domestic violence'
    element :help_forced_marriage, 'li', text: 'forced marriage'
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
