class MaritalStatusPage < BasePage
  include ActiveSupport::Testing::TimeHelpers
  set_url '/questions/marital_status'

  section :content, '#content' do
    element :step_info, '.govuk-caption-l', text: 'Step 6 of 22'
    element :step_info_ucd, '.govuk-caption-l', text: 'Step 9 of 25'
    element :header, 'h1', text: 'Are you single, married or living with someone and sharing an income?'
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
    element :header_ucd, 'h1', text: 'Relationship status'
    element :subheader, 'h2', text: 'Are you single, married or living with someone?'
    element :single, 'label', text: 'Single'
    element :married_ucd, 'label', text: 'Married or living with someone'
    element :single_header, 'h2', text: 'Select ‘Single‘ if:'
    element :married_header, 'h2', text: 'Select ‘Married or living with someone’ if:'
    element :single_point_1, 'li', text: 'you are living alone and relying on your own income with or without dependent children, or'
    element :single_point_2, 'li', text: 'you are permanently separated and may be in the process of applying for a divorce, dissolution or annulment and you are not living with a new partner, or'
    element :single_point_3, 'li', text: 'you have a partner, but they have a conflicting interest in the case you are bringing'
    element :married_point_1, 'li', text: 'you are married or in a civil partnership or'
    element :married_point_2, 'li', text: 'you are living together as if you are married or in a civil partnership or'
    element :married_point_3, 'li', text: 'you have to live apart- for example, one or both of you are serving in the armed forces, in prison or living in residential care'
    element :help_text, 'p', text: 'If you are in a couple, Help with Fees is based on your joint income unless there’s a contrary interest'
  end

  def submit_single
    content.single.click
    continue
  end

  def submit_married
    content.married.click
    continue
  end

  def slowly_submit_single
    travel 61.minutes do
      content.single.click
      continue
    end
  end

  def slowly_submit_partnered
    travel 61.minutes do
      content.married.click
      continue
    end
  end
end
