class PersonalDetailsPage < BasePage
  set_url '/questions/personal_detail'

  section :content, '#content' do
    element :step_info, '.govuk-caption-l', text: 'Step 20 of 25'
    element :header, 'h1', text: 'What is your full name?'
    element :married_header, 'h1', text: 'What are the full names of both you and your partner?'
    element :optional_hint, '.optional', text: 'Optional'
    element :first_name, '#personal_detail_first_name'
    element :last_name, '#personal_detail_last_name'
    element :partner_first_name, '#personal_detail_partner_first_name'
    element :partner_last_name, '#personal_detail_partner_last_name'
  end

  def submit_full_name(title = true)
    fill_in 'Title(Optional)', with: 'Ms' if title
    fill_in 'First name', with: 'Sally'
    fill_in 'Last name', with: 'Smith'
    continue
  end

  def title(str)
    fill_in 'Title(Optional)', with: str
  end

  def first_name(str)
    fill_in 'First name', with: str
  end

  def last_name(str)
    fill_in 'Last name', with: str
  end

  def submit_full_names
    content.first_name.set('Thomas')
    content.last_name.set('Test')
    content.partner_first_name.set('Tina')
    content.partner_last_name.set('Test')
    continue
  end
end
