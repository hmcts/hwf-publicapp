require 'rails_helper'

RSpec.feature 'Session expires when inactive' do

  let(:time_started) { Time.zone.now }
  let(:time_expired) { time_started + 61.minutes }

  scenario 'When user is inactive for given time while answering questions, the session expires' do
    p(Timecop.freeze(time_started))
    Timecop.freeze(time_started) do
      given_user_fills_in_few_questions
    end
    p(Timecop.freeze(time_expired))
    Timecop.freeze(time_expired) do
      when_they_try_to_proceed_after_long_time
      then_they_are_redirected_to_homepage_with_expiry_message
    end
  end

  scenario 'The session does not expire when on the start page' do
    Timecop.freeze(time_started) do
      p(Timecop.freeze(time_started))
      given_user_is_reading_the_home_page
    end
    Timecop.freeze(time_expired) do
      p(Timecop.freeze(time_expired))
      when_they_start_new_application
      then_they_are_on_the_first_question
    end
  end
end
