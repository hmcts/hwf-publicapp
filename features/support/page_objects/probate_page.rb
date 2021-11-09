class ProbatePage < BasePage
  set_url '/questions/probate'

  section :content, '#content' do
    element :step_info, '.govuk-caption-l', text: 'Step 14 of 22'
    element :header, 'h1', text: 'Are you paying a fee for a probate case?'
    element :probate_hint, 'span.govuk-hint', text: 'These cases are usually about the property and belongings of someone who has died.'
    element :yes, 'label', text: 'Yes'
    element :no, 'label', text: 'No'
    element :name_of_deceased, '.govuk-label', text: 'Name of deceased'
    element :probate_deceased_name, '#probate_deceased_name'
    element :probate_day_date_of_death, '#probate_day_date_of_death'
    element :probate_month_date_of_death, '#probate_month_date_of_death'
    element :probate_year_date_of_death, '#probate_year_date_of_death'
    element :blank_error_link, 'a', text: 'Select whether you\'re paying a fee for a probate case'
    element :future_date_error_link, 'a', text: 'This date can\'t be in the future'
    element :expired_date_error_link, 'a', text: 'The date of death must have been in the last 20 years'
    element :invalid_date_error_link, 'a', text: 'Enter the date in this format DD/MM/YYYY'
    element :date_of_death_example, 'span.govuk-hint', text: 'For example, 04 10 2018'
    element :date_of_death_legend, '.govuk-fieldset__legend', text: 'Date of death'
  end

  def answer_probate_yes
    probate_page.content.yes.click
  end

  def day(num)
    content.probate_day_date_of_death.set(num)
  end

  def month(num)
    content.probate_month_date_of_death.set(num)
  end

  def year(num)
    content.probate_year_date_of_death.set(num)
  end

  def submit_probate_no
    probate_page.content.no.click
    continue
  end

  def deceased_name
    probate_page.content.probate_deceased_name.set('John Smith')
  end

  def valid_date_of_death
    date = Time.zone.today - 1.month
    day(date.day)
    month(date.month)
    year(date.year)
    continue
  end

  def date_of_death_over_20_years
    date = Time.zone.today - 21.years
    day(date.day)
    month(date.month)
    year(date.year)

    continue
  end

  def invalid_date_of_death
    day('31')
    month('02')
    year(Time.zone.today.year - 1)
    continue
  end

  def future_date_of_death
    date = Time.zone.today + 1.month
    day(date.day)
    month(date.month)
    year(date.year)

    continue
  end
end
