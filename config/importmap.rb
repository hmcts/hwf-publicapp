# Pin npm packages by running ./bin/importmap
# Application entry point
pin "application"

# External JS packages
pin "jquery", to: "https://code.jquery.com/jquery-3.6.0.min.js"
pin "jquery_ujs", to: "https://cdnjs.cloudflare.com/ajax/libs/jquery-ujs/1.2.2/rails.min.js"
pin "govuk-frontend" # @5.5.0

# Custom JS modules
pin_all_from "modules", under: "modules"