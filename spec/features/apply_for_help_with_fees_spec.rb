require 'rails_helper'

def find_button_by_label(label_text)
  find(:xpath, "//form//input[contains(@class,'govuk-button') and @value='#{label_text}']")
end

def find_continue_button
  find_button_by_label(I18n.t('submit_button'))
end

def find_summary_button
  find_button_by_label(I18n.t('summary.truth.button'))
end

def find_finish_button
  find_button_by_label(I18n.t('confirmation.finish'))
end

RSpec.feature 'As a user' do

  before {
    disable_postcode_lookup
    travel_to a_day_before_disable_probate_fees
    allow(Rails.application.config).to receive(:finish_page_redirect_url).and_return root_url
  }

  after do
    travel_back
    I18n.locale = :en
  end

  I18n.available_locales.each do |locale|
    context "using the #{locale.upcase} language" do

      scenario 'I want to fill in all details, submit my application and see the confirmation' do
        given_the_submission_service_is_available('HWF-123-KLM')

        visit "/?locale=#{locale}"
        click_link_or_button I18n.t('start_application')
        expect(page).to have_content I18n.t('home.checklist.heading')
        click_link_or_button I18n.t('submit_button')
        expect(page).to have_content I18n.t('questions.form_name.text')
        fill_in 'form_name_identifier', with: 'N1'
        find_continue_button.click
        expect(page).to have_content I18n.t('questions.fee.text')
        choose 'fee_paid_false'
        find_continue_button.click
        expect(page).to have_content I18n.t('questions.national_insurance_presence.text')
        choose 'national_insurance_presence_ni_number_present_true'
        find_continue_button.click
        expect(page).to have_content I18n.t('questions.national_insurance.text')
        fill_in 'national_insurance_number', with: 'AB123456A'
        find_continue_button.click
        expect(page).to have_content I18n.t('questions.marital_status.text')
        choose 'marital_status_married_false'
        find_continue_button.click
        expect(page).to have_content I18n.t('questions.savings_and_investment.text')
        choose 'savings_and_investment_choice_less'
        find_continue_button.click
        expect(page).to have_content I18n.t('questions.benefit.text')
        choose 'benefit_on_benefits_false'
        find_continue_button.click
        expect(page).to have_content I18n.t('questions.dependent.text')
        choose 'dependent_children_false'
        find_continue_button.click
        expect(page).to have_content I18n.t('questions.income_kind.text_single')
        check 'income_kind_applicant_1'
        check 'income_kind_applicant_5'
        find_continue_button.click
        expect(page).to have_content I18n.t('questions.income_range.text_single')
        choose 'income_range_choice_between'
        find_continue_button.click
        expect(page).to have_content I18n.t('questions.income_amount.text_single')
        fill_in 'income_amount_amount', with: '100'
        find_continue_button.click
        expect(page).to have_content I18n.t('questions.probate.text')
        choose 'probate_kase_false'
        find_continue_button.click
        expect(page).to have_content I18n.t('questions.claim/default.text')
        choose 'claim_default_number_false'
        find_continue_button.click
        expect(page).to have_content I18n.t('questions.dob.text')
        fill_in 'dob_day', with: '01'
        fill_in 'dob_month', with: '01'
        fill_in 'dob_year', with: '1980'
        find_continue_button.click
        expect(page).to have_content I18n.t('questions.personal_detail.text')
        fill_in 'personal_detail_title', with: 'Sir'
        fill_in 'personal_detail_first_name', with: 'Bob'
        fill_in 'personal_detail_last_name', with: 'Oliver'
        find_continue_button.click
        expect(page).to have_content I18n.t('questions.applicant_address.text')
        fill_in 'applicant_address_street', with: 'Foo Street'
        fill_in 'applicant_address_town', with: 'Foo Town'
        fill_in 'applicant_address_postcode', with: 'Bar'
        find_continue_button.click
        expect(page).to have_content I18n.t('questions.contact.text')
        fill_in 'contact_email', with: 'foo@bar.com'
        find_continue_button.click
        expect(page).to have_content I18n.t('questions.apply_type.text')
        choose 'apply_type_applying_method_paper'
        find_continue_button.click
        expect(page).to have_content I18n.t('summary.labels.title')
        expect(page).to have_content "#{I18n.t('summary.labels.form_name')}N1"
        expect(page).to have_content I18n.t('summary.marital_status_false')
        expect(page).to have_content I18n.t('questions.savings_and_investment.less')
        expect(page).to have_content I18n.t('summary.applicant_on_benefits_false')
        expect(page).to have_content "#{I18n.t('summary.labels.income')}£100"
        expect(page).to have_content "#{I18n.t('summary.labels.fee')}#{I18n.t('summary.fee_paid_false')}"
        expect(page).to have_content "#{I18n.t('summary.labels.probate')}#{I18n.t('summary.probate_case_false')}"
        expect(page).to have_content "#{I18n.t('summary.labels.claim')}#{I18n.t('summary.claim_number_false')}"
        expect(page).to have_content "#{I18n.t('summary.labels.ni_number')}AB123456A"
        expect(page).to have_content "#{I18n.t('summary.labels.date_of_birth')}01/01/1980"
        expect(page).to have_content 'Sir Bob Oliver'
        expect(page).to have_content 'Foo Street'
        expect(page).to have_content 'Bar'
        expect(page).to have_content I18n.t('summary.labels.contact_email')
        expect(page).to have_content 'foo@bar.com'
        expect(page).to have_content I18n.t('summary.labels.apply_type')
        expect(page).to have_content I18n.t('summary.applying_method_paper')
        find_summary_button.click
        expect(page).to have_content I18n.t('confirmation.default.title')
        expect(page).to have_content I18n.t('confirmation.paper.heading')
        expect(page).to have_content I18n.t('confirmation.paper.sub_heading')
        expect(page).to have_content I18n.t('confirmation.paper.h3_two')
        expect(page).to have_content I18n.t('confirmation.paper.p_six')
        find_finish_button.click
        expect(page).to have_content 'Get help paying court and tribunal fees'
      end
    end
  end
end
