class BenefitPage < BasePage
  set_url '/questions/benefit'

  section :content, '#content' do
    element :step_info, '.govuk-caption-l', text: 'Step 9 of 22'
    element :header, 'h1', text: 'Did you receive any of the following benefits?'
    element :benefits_text, 'p', text: 'contact the Department for Work and Pensions'
    element :benefit, 'p'
    elements :li, 'li'
    elements :td, 'td'
    element :no, 'label', text: 'No'
    element :yes, 'label', text: 'Yes, I am receiving one of the benefits listed in Column 1'
    element :help_with_benefits, 'summary', text: 'Help with benefits'
    element :recently_receiving_heading, 'p', text: 'If you’ve only recently started receiving one of these benefits'
    element :provide_a_letter, 'p', text: 'In this case you should provide a letter from the Jobcentre.'
    element :similar_names_heading, 'p', text: 'Benefits with similar names'
    element :benefits_with_similar_names, 'p', text: 'If you are receiving one of the benefits listed below, select \'No\'.'
    element :job_seekers, 'li', text: 'Contribution-based Job Seekers Allowance (JSA)'
    element :employment_support, 'li', text: 'Contribution-based Employment and Support Allowance (ESA)'
    element :pension_credit, 'li', text: 'Pension Credit and Savings Credit'
    element :universal_credit, 'li', text: 'Universal Credit (and you\'re earning more than £6,000 a year)'
    element :laa_assistance, 'li', text: 'Scottish Legal Aid Advice and Assistance'
    element :laa_representation, 'li', text: 'Scottish Legal Aid Advice by Way of Representation (ABWOR)'
    element :blank_error_link, 'a', text: 'Select whether you\'re receiving one of the benefits listed'
  end

  def submit_benefit_no
    content.no.click
    continue
  end

  def submit_benefit_yes
    content.yes.click
    continue
  end
end
