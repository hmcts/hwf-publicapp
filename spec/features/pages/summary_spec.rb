# coding: utf-8
require 'rails_helper'

RSpec.feature 'As a user' do
  context 'when accessing the "summary" page for "Help with fees"' do
    context 'after answering yes to the dependents question' do
      before do
        given_user_answers_questions_up_to(:dependent)
        choose 'dependent_children_true'
        fill_in :dependent_children_number, with: '10'
        click_button 'Continue'
        check :income_kind_applicant_13
        click_button 'Continue'
        page.visit '/summary'
      end

      scenario 'I expect to see my answer' do
        expect(page).to have_content 'Children10'
      end
    end

    context 'after answering no to the dependents question' do
      before do
        given_user_answers_questions_up_to(:dependent)
        choose 'dependent_children_false'
        click_button 'Continue'
        check :income_kind_applicant_13
        click_button 'Continue'
        page.visit '/summary'
      end

      scenario 'I expect to a negative answer' do
        expect(page).to have_content 'ChildrenNo'
      end
    end

    context 'after answering yes to the probate question' do
      before do
        given_user_answers_questions_up_to(:probate)
        choose 'probate_kase_true'
        fill_in :probate_deceased_name, with: 'Foo'
        fill_in :probate_date_of_death, with: Time.zone.today - 1.month
        click_button 'Continue'
        page.visit '/summary'
      end

      scenario 'I expect to see my answers' do
        expect(page).to have_no_content 'Probate case'
        expect(page).to have_content 'Name of deceasedFooChange'
        expect(page).to have_content "Date of death#{(Time.zone.today - 1.month).strftime(Date::DATE_FORMATS[:default])}Change"
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

    context 'after answering yes to all of the contact options' do
      before do
        given_user_answers_questions_up_to(:contact)
        check :contact_feedback_opt_in
        fill_in :contact_email, with: 'foo@bar.com'
        click_button 'Continue'
      end

      scenario 'I expect confirmation ' do
        expect(page).to have_content 'Emailfoo@bar.com'
      end
    end

    context 'after answering no to all of the contact options' do
      before do
        given_user_answers_questions_up_to(:contact)
        click_button 'Continue'
      end

      scenario 'I expect confirmation ' do
        expect(page).to have_content 'Please enter a valid email address in the format yourname@example.co'
      end
    end

    scenario 'the change links take me to the correct page' do
      given_user_provides_all_data
      visit '/summary'
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
end
