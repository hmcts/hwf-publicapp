class PersonalDetailsPage < BasePage
  set_url '/questions/personal_detail'

  section :content, '#content' do
    element :step_info, '.govuk-caption-l', text: 'Step 17 of 22'
    element :header, 'h1', text: 'What is your full name?'
    element :optional_hint, '.optional', text: 'Optional'
  end

  def submit_full_name
    fill_in 'Title(Optional)', with: 'Ms'
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
end
