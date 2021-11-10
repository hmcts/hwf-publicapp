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
      expect(page).to have_text('Step 15 of 22')
      expect(page).not_to have_text('Enter your employment tribunal claim number')

      when_they_continue_from_step12_up_to_summary
      expect(page).to have_text('Step 21 of 22')
      expect(page).to have_text('Check details')

      claim_link = page.find(:xpath, './/dl//div[10]//a')
      expect(claim_link.text).to eql('Change claim number')
      claim_link.click

      expect(page).to have_text('Step 15 of 22')
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
      expect(page).to have_content 'Your application is not yet complete. You now need to take action.'
      expect(page).to have_content 'You must provide the court or tribunal with your reference to proceed'
    end

    scenario 'I expect to "What happens next?" instructions and letter template' do
      within(:xpath, ".//div[@class='steps-panel-confirmation']") do
        expect(page.find(:xpath, './/p[1]').text).to eql "Reference: HWF-ABC123"
        expect(page.find(:xpath, './/p[2]').text).to eql "I have completed on online application for help with fees [insert application type and case number if you have one]."
        expect(page.find(:xpath, './/p[3]').text).to eql "Yours sincerely,"
        expect(page.find(:xpath, './/p[4]').text).to eql "Sir Bob Oliver"
      end

      expect(page).to have_text 'What happens next'
      expect(page).to have_text 'We will contact you within 21 days to tell you if you need to provide more information or you need to pay towards your court or tribunal fee.'
    end

    context 'Welsh' do
      scenario 'I expect to "What happens next?" instructions amd letter template' do
        within(:xpath, ".//p[@class='govuk-phase-banner__content']") do
          click_link 'Cymraeg'
        end

        within(:xpath, ".//div[@class='steps-panel-confirmation']") do
          expect(page.find(:xpath, './/p[1]').text).to eql "Cyfeirnod: HWF-ABC123"
          expect(page.find(:xpath, './/p[2]').text).to eql "Rwyf wedi cwblhau cais ar-lein am help i dalu ffioedd [nodwch y math o gais a rhif yr achos os oes gennych un]."
          expect(page.find(:xpath, './/p[3]').text).to eql "Yn gywir,"
          expect(page.find(:xpath, './/p[4]').text).to eql "Sir Bob Oliver"
        end

        expect(page).to have_text 'Beth fydd yn digwydd nesaf'
        expect(page).to have_text 'Byddwn yn cysylltu â chi o fewn 21 diwrnod i ddweud wrthych a oes angen i chi ddarparu mwy o wybodaeth neu os oes angen i chi dalu rhywfaint tuag at eich ffi llys neu dribiwnlys.'
      end
    end
  end
end
