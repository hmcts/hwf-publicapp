// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "govuk-frontend"
import "jquery"
import "jquery_ujs"
// import "is-nan.polyfill" <- previously in assets/javascripts/application.js. Removed now

import "./modules/module_loader"
import "./modules/form-name"
import "./modules/income-sources"
import "./modules/print-page"
import "./modules/restart-application"
import "./modules/selection-buttons"
import "./modules/show-hide"
import "./modules/uppercase-fields"
import "./modules/address-lookup"
import "./modules/partner-national-insurance"

// Overwrite annoying console message module
// Assuming 'moj' is an existing global variable
// moj.Modules.devs = {};
