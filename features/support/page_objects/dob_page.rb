class DobPage < BasePage
  include ActiveSupport::Testing::TimeHelpers

  set_url '/questions/dob'

  section :content, '#content' do
    element :step_info, '.govuk-caption-l', text: 'Step 19 of 25'
    element :header, 'h1', text: 'What is your date of birth?'
    element :header_partner, 'h1', text: 'What are you and your partner’s date of birth'
    element :dob_hint, '.govuk-hint', text: 'For example, 04 10 1990'
    element :dob_day, '#dob_day'
    element :dob_month, '#dob_month'
    element :dob_year, '#dob_year'
    element :dob_partner_day, '#dob_partner_day'
    element :dob_partner_month, '#dob_partner_month'
    element :dob_partner_year, '#dob_partner_year'
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

  def valid_partner_dob
    content.dob_day.set('28')
    content.dob_month.set('11')
    content.dob_year.set('1992')
    content.dob_partner_day.set('28')
    content.dob_partner_month.set('11')
    content.dob_partner_year.set('1992')
    continue
  end

  def valid_over_66_dob
    age = Time.zone.today - 67.years
    content.dob_day.set(age.day)
    content.dob_month.set(age.month)
    content.dob_year.set(age.year)
    continue
  end

  def valid_partner_over_66_dob
    age = Time.zone.today - 67.years
    content.dob_day.set(age.day)
    content.dob_month.set(age.month)
    content.dob_year.set(age.year)
    content.dob_partner_day.set(age.day)
    content.dob_partner_month.set(age.month)
    content.dob_partner_year.set(age.year)
    continue
  end

  def static_dob
    content.dob_day.set('23')
    content.dob_month.set('07')
    content.dob_year.set('1980')
    continue
  end

  def static_dobs
    content.dob_day.set('23')
    content.dob_month.set('07')
    content.dob_year.set('1980')
    content.dob_partner_day.set('01')
    content.dob_partner_month.set('01')
    content.dob_partner_year.set('1981')
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

  def slow_dob_entry
    travel 61.minutes do
      age = Time.zone.today - 34.years
      content.dob_day.set(age.day)
      content.dob_month.set(age.month)
      content.dob_year.set(age.year)
      continue
    end
  end
end
