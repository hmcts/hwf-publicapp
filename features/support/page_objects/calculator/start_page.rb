require_relative 'base_page'
module Calculator
  class StartPage < ::Calculator::BasePage
    set_url '/calculator'
    element :start_button, :link_or_button, 'Start now'
    def start_session
      start_button.click
    end
  end
end