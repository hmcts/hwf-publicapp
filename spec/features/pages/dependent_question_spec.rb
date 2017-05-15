# coding: utf-8
# frozen_string_literal: true
require 'rails_helper'

RSpec.feature 'As a user' do
  context 'when accessing the "dependent" page for "Help with fees"' do
    before { given_user_answers_questions_up_to(:dependent) }

    context 'completing the form correctly' do
      before do
        choose :dependent_children_true
        fill_in :dependent_children_number, with: '1'
        click_button 'Continue'
      end

      scenario 'I expect to be routed to the "income_kind" page' do
        expect(page).to have_content 'What kind of income do you receive?'
      end
    end

    context 'not completing the page correctly' do
      describe 'leaving all fields empty' do
        before do
          click_button 'Continue'
        end

        scenario 'I expect to be shown the "dependent" page with error block' do
          expect(page).to have_content 'You need to fix the errors on this page before continuing.'
        end

        scenario 'I expect the fields to have specific errors' do
          expect(page).to have_xpath('//span[@class="error-message"]', text: 'You need to say whether you have financially dependent children')
        end
      end

      context 'selecting yes to probate case' do
        before { choose :dependent_children_true }

        context 'leaving children_number blank' do
          before { click_button 'Continue' }

          scenario 'I expect the fields to have specific errors' do
            expect(page).to have_xpath('//span[@class="error-message"]', text: 'You must enter the number of financially dependent children')
          end
        end

        context 'entering text as children_number input' do
          before do
            fill_in :dependent_children_number, with: 'foo'
            click_button 'Continue'
          end

          scenario 'I expect the fields to have specific errors' do
            expect(page).to have_xpath('//span[@class="error-message"]', text: 'You must enter financially dependent children as a number')
          end
        end
      end
    end
  end
end
