class BasePage < SitePrism::Page
  # rubocop:disable Naming/VariableNumber
  section :cookie, '.govuk-cookie-banner' do
    element :header, 'h2', text: 'Cookies on help with fees'
    element :accept_button, "input[value='Accept analytics cookies']"
    element :reject_button, "input[value='Reject analytics cookies']"
  end

  section :content, '#content' do
    element :p, 'p'
    element :h1, 'h1'
    element :h2, 'h2'
    section :alert, 'div.govuk-error-summary' do
      element :there_is_a_problem, 'h2', text: 'There is a problem'
    end
    element :step_number, '.govuk-caption-l'
    element :checklist_continue_button, '.govuk-button', text: 'Continue'
    element :continue_button, 'input[value="Continue"]'
  end
  element :help_with, 'details > summary'

  element :heading_secondary, '.heading-secondary'
  elements :block, '.block'
  section :error_summary, '.govuk-error-summary' do
    element :error_summary_heading, '.error-link'
    element :link, 'a'
  end
  elements :error_message, '.govuk-error-message'
  element :js_print, '.js-print'

  def click_help_with
    help_with.click
  end
  # rubocop:enable Naming/VariableNumber
end
