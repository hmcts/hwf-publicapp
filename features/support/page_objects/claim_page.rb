class ClaimPage < BasePage
  set_url '/questions/claim'

  section :content, '#content' do
    element :step_info, '.govuk-caption-l', text: 'Step 15 of 22'
    element :header, 'h1', text: 'Do you have a case, claim, appeal or ‘notice to pay’ number?'
    element :claim_text, 'span.govuk-hint', text: 'Find this number on letters from the court or tribunal.'
    element :no, 'label', text: 'No'
    element :yes, 'label', text: 'Yes'
    element :claim_input_field, '#claim_default_identifier'
    element :claim_number_label, '.govuk-label', text: 'The case, claim, appeal or ‘notice to pay’ number is'
    element :creates_reference_number_copy, 'p', text: 'The court or tribunal creates a reference number for every case. This is sometimes called a claim number, case number, appeal or ‘notice to pay’ number.'
    element :ongoing_case_copy, 'p', text: 'If your case is ongoing then you’ll find the reference number on letters from the court or tribunal.'
    element :dont_have_reference_number_copy, 'p', text: "Answer 'no' to this question if you don’t have a reference number (this might be because your case hasn’t started yet)."
    element :blank_error_link, 'a', text: 'Select whether you have a case, claim, appeal or ‘notice to pay’ number'
    element :enter_number_error_link, 'a', text: 'Enter a case, claim, appeal or ‘notice to pay’ number'
  end

  def submit_claim_no
    content.no.click
    continue
  end

  def submit_claim_yes
    content.yes.click
    continue
  end

  def input_field(str)
    content.claim_input_field.set(str)
  end

end
