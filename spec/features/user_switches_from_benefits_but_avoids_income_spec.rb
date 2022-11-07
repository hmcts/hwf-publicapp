require 'rails_helper'

RSpec.feature 'User completes their' do
  before { disable_postcode_lookup }

  scenario 'benefit application up to the summary page' do
    given_user_provides_all_data_for_benefit
    find(:xpath, "//a[@href='#{question_path(:benefit, locale: :en)}']").click
    choose :benefit_on_benefits_false
    click_button 'Continue'
    # simulate user returning to summary via the back button (twice)
    visit summary_path
    then_they_cannot_procced
  end

end
