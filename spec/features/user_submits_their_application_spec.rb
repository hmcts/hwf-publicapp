require 'rails_helper'

RSpec.feature 'User submits their application' do
  let(:current_time) { Time.zone.parse('2016-03-29 14:50') }
  let(:reference) { 'HWF-CIDI16' }

  before { disable_postcode_lookup }

  scenario 'User submits their application, but it is not processed' do
    given_user_provides_all_data
    and_the_submission_service_is_unavailable
    when_they_submit_the_application
    then_they_are_redirected_to_the_summary_page_with_error_message
  end

  def then_they_are_presented_with_the_non_refund_confirmation_page_with_reference_number
    expect(page.current_path).to eql('/confirmation')
    expect(page).to have_content(reference)
    expect(page).to have_content('Your application is not yet complete. You now need to take action.')
  end

  def then_they_are_presented_with_the_refund_confirmation_page_with_reference_number
    expect(page.current_path).to eql('/confirmation/refund')
    expect(page).to have_content('You must provide the court or tribunal with your reference to proceed')
    expect(page).to have_content(reference)
    expect(page).to have_content('on 08/03/2016')
    expect(page).to have_content('Sir Bob Oliver')
  end

  def then_they_are_redirected_to_the_summary_page_with_error_message
    expect(page.current_path).to eql('/summary')
    expect(page).to have_text("We couldn't process your application at this time. Please try again later.")
  end
end
