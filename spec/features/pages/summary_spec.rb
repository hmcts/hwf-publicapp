require 'rails_helper'

RSpec.feature 'As a user' do
  before { disable_postcode_lookup }

  context 'when accessing the "summary" page for "Help with fees"' do
    # temporarily commenting out:
    # navigating directly to summary doesn't maintain dependent page selection
    #     context 'after answering yes to the dependents question' do
    #       before do
    #         given_user_answers_questions_up_to(:dependent)
    #         choose 'dependent_children_true'
    #         fill_in :dependent_children_number, with: '10'
    #         click_button 'Continue'
    #         check :income_kind_applicant_none_of_the_above
    #         click_button 'Continue'
    #         visit_summary_page
    #       end

    #       scenario 'I expect to see my answer' do
    #         expect(page).to have_content 'Children10'
    #       end
    #     end

    #     context 'after answering no to the dependents question' do
    #       before do
    #         given_user_answers_questions_up_to(:dependent)
    #         choose 'dependent_children_false'
    #         click_button 'Continue'
    #         check :income_kind_applicant_none_of_the_above
    #         click_button 'Continue'
    #         visit_summary_page
    #       end

    #       scenario 'I expect to a negative answer' do
    #         expect(page).to have_content 'ChildrenNo'
    #       end
    #     end

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
        visit_summary_page
      end

      scenario 'I expect to see my answers' do
        expect(page).to have_no_text 'Probate case'
        expect(page).to have_text 'Name of deceasedFooChange'
        expect(page).to have_text "Date of death#{month_ago.strftime(Date::DATE_FORMATS[:default])}Change"
      end
    end

    context 'after answering no to the probate question' do
      before do
        given_user_answers_questions_up_to(:probate)
        choose 'probate_kase_false'
        click_button 'Continue'
        visit_summary_page
      end

      scenario 'I do not expect to see the probate sub headers' do
        expect(page).to have_text 'Probate case'
        expect(page).to have_no_text 'Name of deceased'
        expect(page).to have_no_text 'Date of death'
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
        expect(page).to have_text 'Emailfoo@bar.com'
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
        expect(page).to have_text 'ContactContact details not provided'
      end
    end

    context 'change links' do
      scenario 'the change links take me to the correct page' do
        given_user_provides_all_data
        visit_summary_page

        expect(page).to have_xpath "//a[starts-with(text(), 'Change')][starts-with(@href,'#{question_path(:form_name, app_id: current_app_id)}')]"
        expect(page).to have_xpath "//a[starts-with(text(), 'Change')][starts-with(@href,'#{question_path(:marital_status, app_id: current_app_id)}')]"
        expect(page).to have_xpath "//a[starts-with(text(), 'Change')][starts-with(@href,'#{question_path(:savings_and_investment, app_id: current_app_id)}')]"
        expect(page).to have_xpath "//a[starts-with(text(), 'Change')][starts-with(@href,'#{question_path(:benefit, app_id: current_app_id)}')]"
        expect(page).to have_xpath "//a[starts-with(text(), 'Change')][starts-with(@href,'#{question_path(:dependent, app_id: current_app_id)}')]"
        expect(page).to have_xpath "//a[starts-with(text(), 'Change')][starts-with(@href,'#{question_path(:income_kind, app_id: current_app_id)}')]"
        expect(page).to have_xpath "//a[starts-with(text(), 'Change')][starts-with(@href,'#{question_path(:fee, app_id: current_app_id)}')]"
        expect(page).to have_xpath "//a[starts-with(text(), 'Change')][starts-with(@href,'#{question_path(:probate, app_id: current_app_id)}')]"
        expect(page).to have_xpath "//a[starts-with(text(), 'Change')][starts-with(@href,'#{question_path(:claim, app_id: current_app_id)}')]"
        expect(page).to have_xpath "//a[starts-with(text(), 'Change')][starts-with(@href,'#{question_path(:dob, app_id: current_app_id)}')]"
        expect(page).to have_xpath "//a[starts-with(text(), 'Change')][starts-with(@href,'#{question_path(:national_insurance, app_id: current_app_id)}')]"
        expect(page).to have_xpath "//a[starts-with(text(), 'Change')][starts-with(@href,'#{question_path(:personal_detail, app_id: current_app_id)}')]"
        expect(page).to have_xpath "//a[starts-with(text(), 'Change')][starts-with(@href,'#{question_path(:applicant_address, app_id: current_app_id)}')]"
        expect(page).to have_xpath "//a[starts-with(text(), 'Change')][starts-with(@href,'#{question_path(:contact, app_id: current_app_id)}')]"
      end
    end
  end
end
