class DobPage < BasePage
  set_url '/questions/dob'

  section :content, '#content' do
    element :step_info, '.govuk-caption-l', text: 'Step 16 of 22'
    element :header, 'h1', text: 'What is your date of birth?'
    element :dob_hint, '.govuk-hint', text: 'For example, 04 10 2018'
    element :dob_day, '#dob_day'
    element :dob_month, '#dob_month'
    element :dob_year, '#dob_year'
    element :blank_error_link, 'a', text: 'Enter the date in this format DD/MM/YYYY'
    element :under_age_error_link, 'a', text: 'You must be over 15 to use this service'
    element :over_age_error_link, 'a', text: 'Check this date of birth is correct'
  end

  def valid_dob
    age = Time.zone.today - 34.years
    content.dob_day.set(age.day)
    content.dob_month.set(age.month)
    content.dob_year.set(age.year)
    continue
  end

  def static_dob
    content.dob_day.set('23')
    content.dob_month.set('07')
    content.dob_year.set('1980')
    continue
  end

  def under_age_dob
    age = Time.zone.today - 14.years
    content.dob_day.set(age.day)
    content.dob_month.set(age.month)
    content.dob_year.set(age.year)
    continue
  end

  def over_age_dob
    age = Time.zone.today - 150.years
    content.dob_day.set(age.day)
    content.dob_month.set(age.month)
    content.dob_year.set(age.year)

    continue
  end
end
