class DependentPage < BasePage
  include ActiveSupport::Testing::TimeHelpers
  set_url '/questions/dependent'

  section :content, '#content' do
    element :step_info, '.govuk-caption-l', text: 'Step 14 of 25'
    element :header, 'h1', text: 'Children that live with you or you’re supporting financially'
    element :no, 'label', text: 'No'
    element :yes, 'label', text: 'Yes'
    element :num_of_children, '.govuk-label', text: 'Number of children'
    element :children_number, '#dependent_children_number'
    element :children_number_ucd, '#dependent_children_age_band_one'
    element :details_content, '#details-content-0'
    # element :give_details, 'p', text: 'You need to give details of any children you are your partner support financially.'
    element :give_details, 'p', text: 'You need to give details of any children you support financially.'
    element :includes_children, 'p', text: 'They must be:'
    element :children_under, 'li', text: 'under 16 and living at home with you or'
    # element :regular_maintenance, 'li', text: 'not living with you, but you or your partner pay regular maintenance for them or'
    element :regular_maintenance, 'li', text: 'not living with you, but you pay regular maintenance for them or'
    element :children_between, 'li', text: 'between 16 and 19, living at home with you and in full-time education (not including studying for a degree or other higher education qualification). See '
    element :child_tax_link, 'a', text: 'gov.uk/child-tax-credit-when-child-reaches-16'
    element :error_link, 'a', text: 'You need to say whether you have financially dependent children'
  end

  def submit_dependent_no
    content.no.click
    continue
  end

  def slow_submit_dependent_no
    travel 61.minutes do
      content.no.click
      continue
    end
  end

  def dependent_yes
    content.yes.click
  end

  def submit_dependent_3_ucd
    content.yes.click
    content.children_number_ucd.set 3
    continue
  end

  def submit_dependent_3
    content.yes.click
    content.children_number.set 3
    continue
  end

  def children_number(num)
    content.children_number.set num
  end

  def children_number_ucd(num)
    content.children_number_ucd.set num
  end

  def slow_submit_dependent_yes
    travel 61.minutes do
      content.yes.click
      continue
    end
  end
end
