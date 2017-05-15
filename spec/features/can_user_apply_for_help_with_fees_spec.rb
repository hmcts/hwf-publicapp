# frozen_string_literal: true
require 'rails_helper'

RSpec.feature 'As a user' do

  let(:conditions_of_application) { "And you’re either on benefits" }

  scenario 'I want to learn if I can apply for "Help with fees"' do
    visit '/'
    expect(page).to have_content conditions_of_application
  end
end
