import { initAll } from 'govuk-frontend'
initAll();

import Rails from 'rails-ujs'
Rails.start();

import 'jquery'

global.$ = require("jquery");
global.jQuery = global.$;

import 'jquery3'
import 'jquery_ujs'

import 'is-nan.polyfill'

import './modules/module_loader'
import './modules/form-name'
import './modules/income-sources'
import './modules/print-page'
import './modules/restart-application'
import './modules/selection-buttons'
import './modules/show-hide'
import './modules/uppercase-fields'
import './modules/address-lookup'
import './modules/partner-national-insurance.js'
import './modules/select-children-show.js'

