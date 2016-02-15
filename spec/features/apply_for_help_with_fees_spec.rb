# coding: utf-8
require 'rails_helper'

RSpec.feature 'As a user' do
  scenario 'I want to start the application for "Help with fees"' do
    page.visit '/'
    page.click_link 'Apply now'
  end

  scenario 'I want to add my marital status' do
    page.visit '/'
    page.click_link 'Apply now'
    expect(page).to have_content "What's your status?"
    choose 'marital_status_married_false'
    click_button 'Continue'
  end

  scenario 'I want to add information on my savings and investments' do
    page.visit '/'
    page.click_link 'Apply now'
    expect(page).to have_content "What's your status?"
    choose 'marital_status_married_false'
    click_button 'Continue'
    expect(page).to have_content 'How much do you have in savings and investments?'
    choose 'savings_and_investment_less_than_limit_false'
    click_button 'Continue'
  end

  scenario 'I want to add information on benefits' do
    page.visit '/'
    page.click_link 'Apply now'
    expect(page).to have_content "What's your status?"
    choose 'marital_status_married_false'
    click_button 'Continue'
    expect(page).to have_content 'How much do you have in savings and investments?'
    choose 'savings_and_investment_less_than_limit_false'
    click_button 'Continue'
    expect(page).to have_content 'Do you receive any of the following benefits?'
    choose 'benefit_on_benefits_false'
    click_button 'Continue'
  end

  scenario 'I want to add information on fee payment' do
    page.visit '/'
    page.click_link 'Apply now'
    expect(page).to have_content "What's your status?"
    choose 'marital_status_married_false'
    click_button 'Continue'
    expect(page).to have_content 'How much do you have in savings and investments?'
    choose 'savings_and_investment_less_than_limit_false'
    click_button 'Continue'
    expect(page).to have_content 'Do you receive any of the following benefits?'
    choose 'benefit_on_benefits_false'
    click_button 'Continue'
    expect(page).to have_content 'Have you already paid the fee?'
    choose 'fee_paid_false'
    click_button 'Continue'
  end

  scenario 'I want to add information on probate case' do
    page.visit '/'
    page.click_link 'Apply now'
    expect(page).to have_content "What's your status?"
    choose 'marital_status_married_false'
    click_button 'Continue'
    expect(page).to have_content 'How much do you have in savings and investments?'
    choose 'savings_and_investment_less_than_limit_false'
    click_button 'Continue'
    expect(page).to have_content 'Do you receive any of the following benefits?'
    choose 'benefit_on_benefits_false'
    click_button 'Continue'
    expect(page).to have_content 'Have you already paid the fee?'
    choose 'fee_paid_false'
    click_button 'Continue'
    expect(page).to have_content 'Are you paying a fee for a probate case?'
    choose 'probate_kase_false'
    click_button 'Continue'
  end

  scenario 'I want to add my national insurance number' do
    page.visit '/'
    page.click_link 'Apply now'
    expect(page).to have_content "What's your status?"
    choose 'marital_status_married_false'
    click_button 'Continue'
    expect(page).to have_content 'How much do you have in savings and investments?'
    choose 'savings_and_investment_less_than_limit_false'
    click_button 'Continue'
    expect(page).to have_content 'Do you receive any of the following benefits?'
    choose 'benefit_on_benefits_false'
    click_button 'Continue'
    expect(page).to have_content 'Have you already paid the fee?'
    choose 'fee_paid_false'
    click_button 'Continue'
    expect(page).to have_content 'Are you paying a fee for a probate case?'
    choose 'probate_kase_false'
    click_button 'Continue'
    expect(page).to have_content 'Do you have a case, claim or ‘notice to pay’ number?'
    choose 'claim_number_false'
    click_button 'Continue'
  end

  scenario 'I want to add information on case or claim' do
    page.visit '/'
    page.click_link 'Apply now'
    expect(page).to have_content "What's your status?"
    choose 'marital_status_married_false'
    click_button 'Continue'
    expect(page).to have_content 'How much do you have in savings and investments?'
    choose 'savings_and_investment_less_than_limit_false'
    click_button 'Continue'
    expect(page).to have_content 'Do you receive any of the following benefits?'
    choose 'benefit_on_benefits_false'
    click_button 'Continue'
    expect(page).to have_content 'Have you already paid the fee?'
    choose 'fee_paid_false'
    click_button 'Continue'
    expect(page).to have_content 'Are you paying a fee for a probate case?'
    choose 'probate_kase_false'
    click_button 'Continue'
    expect(page).to have_content 'Do you have a case, claim or ‘notice to pay’ number?'
    choose 'claim_number_false'
    click_button 'Continue'
    expect(page).to have_content 'What is the form name or number related to this application?'
    fill_in 'form_name_identifier', with: 'N1'
    click_button 'Continue'
  end

  scenario 'I want to add national insurance number' do
    page.visit '/'
    page.click_link 'Apply now'
    expect(page).to have_content "What's your status?"
    choose 'marital_status_married_false'
    click_button 'Continue'
    expect(page).to have_content 'How much do you have in savings and investments?'
    choose 'savings_and_investment_less_than_limit_false'
    click_button 'Continue'
    expect(page).to have_content 'Do you receive any of the following benefits?'
    choose 'benefit_on_benefits_false'
    click_button 'Continue'
    expect(page).to have_content 'Have you already paid the fee?'
    choose 'fee_paid_false'
    click_button 'Continue'
    expect(page).to have_content 'Are you paying a fee for a probate case?'
    choose 'probate_kase_false'
    click_button 'Continue'
    expect(page).to have_content 'Do you have a case, claim or ‘notice to pay’ number?'
    choose 'claim_number_false'
    click_button 'Continue'
    expect(page).to have_content 'What is the form name or number related to this application?'
    fill_in 'form_name_identifier', with: 'N1'
    click_button 'Continue'
    expect(page).to have_content 'What is your National Insurance number?'
    fill_in 'national_insurance_number', with: 'AB123456A'
    click_button 'Continue'
  end

  scenario 'I want to add my personal information' do
    page.visit '/'
    page.click_link 'Apply now'
    expect(page).to have_content "What's your status?"
    choose 'marital_status_married_false'
    click_button 'Continue'
    expect(page).to have_content 'How much do you have in savings and investments?'
    choose 'savings_and_investment_less_than_limit_false'
    click_button 'Continue'
    expect(page).to have_content 'Do you receive any of the following benefits?'
    choose 'benefit_on_benefits_false'
    click_button 'Continue'
    expect(page).to have_content 'Have you already paid the fee?'
    choose 'fee_paid_false'
    click_button 'Continue'
    expect(page).to have_content 'Are you paying a fee for a probate case?'
    choose 'probate_kase_false'
    click_button 'Continue'
    expect(page).to have_content 'Do you have a case, claim or ‘notice to pay’ number?'
    choose 'claim_number_false'
    click_button 'Continue'
    expect(page).to have_content 'What is the form name or number related to this application?'
    fill_in 'form_name_identifier', with: 'N1'
    click_button 'Continue'
    expect(page).to have_content 'What is your National Insurance number?'
    fill_in 'national_insurance_number', with: 'AB123456A'
    click_button 'Continue'
    expect(page).to have_content 'What is your full name?'
    fill_in 'personal_detail_title', with: 'Sir'
    fill_in 'personal_detail_first_name', with: 'Bob'
    fill_in 'personal_detail_last_name', with: 'Oliver'
    click_button 'Continue'
  end

  scenario 'I want to see the summary of my application' do
    page.visit '/'
    page.click_link 'Apply now'
    expect(page).to have_content "What's your status?"
    choose 'marital_status_married_false'
    click_button 'Continue'
    expect(page).to have_content 'How much do you have in savings and investments?'
    choose 'savings_and_investment_less_than_limit_false'
    click_button 'Continue'
    expect(page).to have_content 'Do you receive any of the following benefits?'
    choose 'benefit_on_benefits_false'
    click_button 'Continue'
    expect(page).to have_content 'Have you already paid the fee?'
    choose 'fee_paid_false'
    click_button 'Continue'
    expect(page).to have_content 'Are you paying a fee for a probate case?'
    choose 'probate_kase_false'
    click_button 'Continue'
    expect(page).to have_content 'Do you have a case, claim or ‘notice to pay’ number?'
    choose 'claim_number_false'
    click_button 'Continue'
    expect(page).to have_content 'What is the form name or number related to this application?'
    fill_in 'form_name_identifier', with: 'N1'
    click_button 'Continue'
    expect(page).to have_content 'What is your National Insurance number?'
    fill_in 'national_insurance_number', with: 'AB123456A'
    click_button 'Continue'
    fill_in 'personal_detail_title', with: 'Sir'
    fill_in 'personal_detail_first_name', with: 'Bob'
    fill_in 'personal_detail_last_name', with: 'Oliver'
    click_button 'Continue'
    expect(page).to have_content 'Check details'
    expect(page).to have_content 'Single'
    expect(page).to have_content 'Less than £3,000'
    expect(page).to have_content 'Not receiving eligible benefits'
    expect(page).to have_content 'Fee paidNo'
    expect(page).to have_content 'Probate caseNo'
    expect(page).to have_content 'Claim numberNo'
    expect(page).to have_content 'Form nameN1'
    expect(page).to have_content 'National insurance numberAB123456A'
    expect(page).to have_content 'Sir Bob Oliver'
  end
end
