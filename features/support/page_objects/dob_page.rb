class DobPage < BasePage
  set_url '/questions/dob'

  section :content, '#content' do
    element :step_info, '.step-info', text: 'Step 14 of 20'
    element :dob_header, 'h1', text: 'What is your date of birth?'
    element :dob_hint, '.hint', text: 'For example, 01 08 2007'
    element :dob_day_date_of_birth, '#dob_day_date_of_birth'
    element :dob_month_date_of_birth, '#dob_month_date_of_birth'
    element :dob_year_date_of_birth, '#dob_year_date_of_birth'
    element :blank_error_link, 'a', text: 'Enter the date in this format DD/MM/YYYY'
    element :blank_error_message, '.error-message', text: 'Enter the date in this format DD/MM/YYYY'
    element :under_age_error_link, 'a', text: 'You must be over 15 to use this service'
    element :under_age_error_message, '.error-message', text: 'You must be over 15 to use this service'
    element :over_age_error_link, 'a', text: 'Check this date of birth is correct'
    element :over_age_error_message, '.error-message', text: 'Check this date of birth is correct'
  end

  def valid_dob
    age = Time.zone.today - 34.years
    content.dob_day_date_of_birth.set(age.day)
    content.dob_month_date_of_birth.set(age.month)
    content.dob_year_date_of_birth.set(age.year)
    continue
  end

  def under_age_dob
    age = Time.zone.today - 14.years
    content.dob_day_date_of_birth.set(age.day)
    content.dob_month_date_of_birth.set(age.month)
    content.dob_year_date_of_birth.set(age.year)
    continue
  end

  def over_age_dob
    age = Time.zone.today - 150.years
    content.dob_day_date_of_birth.set(age.day)
    content.dob_month_date_of_birth.set(age.month)
    content.dob_year_date_of_birth.set(age.year)

    continue
  end
end
