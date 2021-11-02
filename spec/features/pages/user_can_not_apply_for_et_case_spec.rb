require 'rails_helper'

RSpec.feature 'As a user' do
  before {
    disable_postcode_lookup
    travel_to a_day_before_disable_probate_fees
  }

  after { travel_back }

  context 'I should not to be able to apply for help with fees for with ET' do
    before do
      given_the_submission_service_is_available
      when_they_go_back_to_homepage_and_start_again
    end

    scenario "can't select ET option in step 1" do
      expect(page).not_to have_text('I need help with an employment tribunal fee')
    end

    scenario "should not be go able to go to step 12 and fill ET number" do
      when_they_apply_for_help_with_et_case_up_to_step_12
      expect(page).to have_text('Step 15 of 23')
      expect(page).not_to have_text('Enter your employment tribunal claim number')

      when_they_continue_from_step12_up_to_summary
      expect(page).to have_text('Step 20 of 23')
      expect(page).to have_text('Check details')

      claim_link = page.find(:xpath, './/dl//div[10]//a')
      expect(claim_link.text).to eql('Change claim number')
      claim_link.click

      expect(page).to have_text('Step 15 of 23')
      expect(page).not_to have_text('Enter your employment tribunal claim number')
      expect(page).to have_text('Do you have a case, claim, appeal or ‘notice to pay’ number?')
    end

  end

  context 'I should to be able to apply for help with fees for with ET form name case' do
    before do
      given_the_submission_service_is_available
      when_they_apply_for_help_with_et_case
    end

    scenario 'I expect to see instructions how to finish application' do
      expect(page).to have_content 'Your application for help with fees is not finished yet'
      expect(page).to have_content 'You must write this reference number HWF-ABC123 on your ET form'
    end

    scenario 'I expect to "What happens next?" instructions' do
      click_button "Continue"
      within(:xpath, ".//div[@class='steps-panel']") do
        expect(page).to have_text 'What happens next?'
        expect(page.find(:xpath, './/ol/li[1]').text).to eql 'Your application will be assessed by court or tribunal staff. This usually takes no longer than 21 days.'
        expect(page.find(:xpath, './/ol/li[2]').text).to eql "You'll hear from the court or tribunal if your application is unsuccessful or if they need more information from you."
        expect(page.find(:xpath, './/ol/li[3]').text).to eql("If your application is successful you'll hear directly from the court or tribunal dealing with your case.")
      end
    end

    context 'Welsh' do
      scenario 'I expect to "What happens next?" instructions' do
        within(:xpath, ".//p[@class='govuk-phase-banner__content']") do
          click_link 'Cymraeg'
        end

        click_button 'Parhau'
        within(:xpath, ".//div[@class='steps-panel']") do
          expect(page).to have_text 'Beth fydd yn digwydd nesaf?'
          expect(page.find(:xpath, './/ol/li[1]').text).to eql "Bydd eich cais yn cael ei asesu gan staff y llys neu dribiwnlys. Fel arfer ni fydd hyn yn cymryd mwy na 21 diwrnod."
          expect(page.find(:xpath, './/ol/li[2]').text).to eql "Byddwch chi'n clywed oddi wrth y llys neu dribiwnlys os nad yw'ch cais yn llwyddiannus neu os oes angen i chi roi gwybodaeth ychwanegol iddynt."
          expect(page.find(:xpath, './/ol/li[3]').text).to eql "Os bydd eich cais yn llwyddiannus, byddwch chi'n clywed yn uniongyrchol gan y llys neu dribiwnlys sy'n delio â'ch achos."
        end
      end
    end
  end
end
