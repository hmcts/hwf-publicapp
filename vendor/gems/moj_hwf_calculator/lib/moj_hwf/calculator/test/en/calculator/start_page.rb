module MojHwf
  module Calculator
    module Test
      module En
        module Calculator
          class StartPage < BasePage
            set_url '/calculator'
            element :start_button, :link_or_button, 'Start now'
            def start_session
              start_button.click
            end
          end
        end
      end
    end
  end
end
