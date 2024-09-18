require 'rails_helper'

RSpec.feature 'As a user' do
  before { disable_postcode_lookup }

  context 'when accessing the "summary" page for "Help with fees"' do
    # temporarily commenting out:
    # navigating directly to summary doesn't maintain dependent page selection

    # context 'after answering yes to the dependents question' do
    #   before do
    #     given_user_answers_questions_up_to(:dependent)
    #     choose 'dependent_children_true'
    #     fill_in :dependent_children_age_band_one, with: '10'
    #     click_button 'Continue'
    #     check :income_kind_applicant_13
    #     click_button 'Continue'
    #     page.visit '/summary'
    #   end
    #
    #   scenario 'I expect to see my answer' do
    #     expect(page).to have_content 'Children10'
    #   end
    # end
    #
    # context 'after answering no to the dependents question' do
    #   before do
    #     given_user_answers_questions_up_to(:dependent)
    #     choose 'dependent_children_false'
    #     click_button 'Continue'
    #     check :income_kind_applicant_13
    #     click_button 'Continue'
    #     page.visit '/summary'
    #   end
    #
    #   scenario 'I expect to a negative answer' do
    #     expect(page).to have_content 'ChildrenNo'
    #   end
    # end

    context 'when probate fess is still active' do
      before { travel_to a_day_before_disable_probate_fees }

      context 'after answering yes to the probate question' do
        let(:month_ago) { Time.zone.today - 1.month }

        before do
          given_user_answers_questions_up_to(:probate)
          choose 'probate_kase_true'
          fill_in :probate_deceased_name, with: 'Foo'
          fill_in :probate_day_date_of_death, with: month_ago.day
          fill_in :probate_month_date_of_death, with: month_ago.month
          fill_in :probate_year_date_of_death, with: month_ago.year
          click_button 'Continue'
          page.visit '/summary'
        end

        scenario 'I expect to see my answers' do
          expect(page).to have_no_content 'Probate case'
          expect(page).to have_content 'Name of deceasedFooChange'
          expect(page).to have_content "Date of death#{month_ago.strftime(Date::DATE_FORMATS[:default])}Change"
        end
      end

      context 'after answering no to the probate question' do
        before do
          given_user_answers_questions_up_to(:probate)
          choose 'probate_kase_false'
          click_button 'Continue'
          page.visit '/summary'
        end

        scenario 'I do not expect to see the probate sub headers' do
          expect(page).to have_content 'Probate case'
          expect(page).to have_no_content 'Name of deceased'
          expect(page).to have_no_content 'Date of death'
        end
      end

    end

    context 'after answering yes to all of the contact options' do
      before do
        given_user_answers_questions_up_to(:contact)
        check :contact_feedback_opt_in
        fill_in :contact_email, with: 'foo@bar.com'
        click_button 'Continue'
        choose 'apply_type_applying_method_paper'
        click_button 'Continue'
      end

      scenario 'I expect confirmation' do
        expect(page).to have_content 'Emailfoo@bar.com'
      end
    end

    context 'after answering no to all of the contact options' do
      before do
        given_user_answers_questions_up_to(:contact)
        click_button 'Continue'
        choose 'apply_type_applying_method_paper'
        click_button 'Continue'
      end

      scenario 'I expect confirmation' do
        expect(page).to have_content 'ContactContact details not provided'
      end
    end

    context 'when probate is still active' do
      scenario 'the change links take me to the correct page' do
        travel_to(a_day_before_disable_probate_fees) do
          given_user_provides_all_data
          visit '/summary'
        end

        expect(page).to have_xpath "//a[starts-with(text(), 'Change')][starts-with(@href,'#{question_path(:form_name)}')]"
        expect(page).to have_xpath "//a[starts-with(text(), 'Change')][starts-with(@href,'#{question_path(:marital_status)}')]"
        expect(page).to have_xpath "//a[starts-with(text(), 'Change')][starts-with(@href,'#{question_path(:savings_and_investment)}')]"
        expect(page).to have_xpath "//a[starts-with(text(), 'Change')][starts-with(@href,'#{question_path(:benefit)}')]"
        expect(page).to have_xpath "//a[starts-with(text(), 'Change')][starts-with(@href,'#{question_path(:dependent)}')]"
        expect(page).to have_xpath "//a[starts-with(text(), 'Change')][starts-with(@href,'#{question_path(:income_kind)}')]"
        expect(page).to have_xpath "//a[starts-with(text(), 'Change')][starts-with(@href,'#{question_path(:fee)}')]"
        expect(page).to have_xpath "//a[starts-with(text(), 'Change')][starts-with(@href,'#{question_path(:probate)}')]"
        expect(page).to have_xpath "//a[starts-with(text(), 'Change')][starts-with(@href,'#{question_path(:claim)}')]"
        expect(page).to have_xpath "//a[starts-with(text(), 'Change')][starts-with(@href,'#{question_path(:dob)}')]"
        expect(page).to have_xpath "//a[starts-with(text(), 'Change')][starts-with(@href,'#{question_path(:national_insurance)}')]"
        expect(page).to have_xpath "//a[starts-with(text(), 'Change')][starts-with(@href,'#{question_path(:personal_detail)}')]"
        expect(page).to have_xpath "//a[starts-with(text(), 'Change')][starts-with(@href,'#{question_path(:applicant_address)}')]"
        expect(page).to have_xpath "//a[starts-with(text(), 'Change')][starts-with(@href,'#{question_path(:contact)}')]"
      end
    end

    context 'when probate is deactivated' do
      scenario 'the change links take me to the correct page' do
        travel_to(probate_fees_release_date) do
          given_user_provides_all_data
          visit '/summary'
        end

        expect(page).to have_xpath "//a[starts-with(text(), 'Change')][starts-with(@href,'#{question_path(:form_name)}')]"
        expect(page).to have_xpath "//a[starts-with(text(), 'Change')][starts-with(@href,'#{question_path(:marital_status)}')]"
        expect(page).to have_xpath "//a[starts-with(text(), 'Change')][starts-with(@href,'#{question_path(:savings_and_investment)}')]"
        expect(page).to have_xpath "//a[starts-with(text(), 'Change')][starts-with(@href,'#{question_path(:benefit)}')]"
        expect(page).to have_xpath "//a[starts-with(text(), 'Change')][starts-with(@href,'#{question_path(:dependent)}')]"
        expect(page).to have_xpath "//a[starts-with(text(), 'Change')][starts-with(@href,'#{question_path(:income_kind)}')]"
        expect(page).to have_xpath "//a[starts-with(text(), 'Change')][starts-with(@href,'#{question_path(:fee)}')]"
        expect(page).to have_no_xpath "//a[starts-with(text(), 'Change')][starts-with(@href,'#{question_path(:probate)}')]"
        expect(page).to have_xpath "//a[starts-with(text(), 'Change')][starts-with(@href,'#{question_path(:claim)}')]"
        expect(page).to have_xpath "//a[starts-with(text(), 'Change')][starts-with(@href,'#{question_path(:dob)}')]"
        expect(page).to have_xpath "//a[starts-with(text(), 'Change')][starts-with(@href,'#{question_path(:national_insurance)}')]"
        expect(page).to have_xpath "//a[starts-with(text(), 'Change')][starts-with(@href,'#{question_path(:personal_detail)}')]"
        expect(page).to have_xpath "//a[starts-with(text(), 'Change')][starts-with(@href,'#{question_path(:applicant_address)}')]"
        expect(page).to have_xpath "//a[starts-with(text(), 'Change')][starts-with(@href,'#{question_path(:contact)}')]"
      end
    end
  end
end
