class DependentPage < BasePage
  include ActiveSupport::Testing::TimeHelpers
  set_url '/questions/dependent'

  section :content, '#content' do
    element :step_info, '.govuk-caption-l', text: 'Step 14 of 25'
    element :header, 'h1', text: 'Children that live with you or you’re supporting financially'
    element :num_of_children, '.govuk-label', text: 'Number of children'
    element :children_number, '#dependent_children_number'
    element :details_content, '#details-content-0'
    element :give_details, 'p', text: 'You need to give details of any children you support financially.'
    element :includes_children, 'p', text: 'They must be:'
    element :children_under, 'li', text: 'under 16 and living at home with you or'
    element :regular_maintenance, 'li', text: 'not living with you, but you pay regular maintenance for them or'
    element :children_between, 'li', text: 'between 16 and 19, living at home with you and in full-time education (not including studying for a degree or other higher education qualification). See '
    element :child_tax_link, 'a', text: 'gov.uk/child-tax-credit-when-child-reaches-16'
    element :error_link, 'a', text: 'You need to say whether you have financially dependent children'
  end

  def submit_dependent_no
    content.children_number.select 0
    continue
  end

  def slow_submit_dependent_no
    travel 61.minutes do
      content.children_number.select 0
      continue
    end
  end

  def dependent_yes
    content.yes.click
  end

  def submit_dependent_3
    content.children_number.select 3
    continue
  end

  def slow_submit_dependent_yes
    travel 61.minutes do
      content.children_number.select 1
      continue
    end
  end

  def submit_child_bands
    all('select', text: 'Select the child\'s age range').each do |child|
      child.select '0-13 years'
    end
    continue
  end
end
