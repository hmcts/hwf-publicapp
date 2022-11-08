require Rails.root.join('spec/support/probate_fees_switchover_helper.rb')

def probate_disabled
  disable_address_lookup
  travel_to probate_fees_release_date + 1.day
  log "probate is disabled: #{ProbateFeesSwitch.disable_probate_fees?}"
end

def probate_enabled
  disable_address_lookup
  travel_to a_day_before_disable_probate_fees
  print "probate is disabled: #{ProbateFeesSwitch.disable_probate_fees?}"
end

def checklist_page
  @checklist_page ||= ChecklistPage.new
end

def form_name_page
  @form_name_page ||= FormNamePage.new
end

def fee_page
  @fee_page ||= FeePage.new
end

def marital_status_page
  @marital_status_page ||= MaritalStatusPage.new
end

def savings_investment_page
  @savings_investment_page ||= SavingsInvestmentPage.new
end

def savings_investment_extra_page
  @savings_investment_extra_page ||= SavingsInvestmentExtraPage.new
end

def benefit_page
  @benefit_page ||= BenefitPage.new
end

def dependent_page
  @dependent_page ||= DependentPage.new
end

def income_kind_page
  @income_kind_page ||= IncomeKindPage.new
end

def income_range_page
  @income_range_page ||= IncomeRangePage.new
end

def income_amount_page
  @income_amount_page ||= IncomeAmountPage.new
end

def probate_page
  @probate_page ||= ProbatePage.new
end

def claim_page
  @claim_page ||= ClaimPage.new
end

def national_insurance_page
  @national_insurance_page ||= NationalInsurancePage.new
end

def national_insurance_presence_page
  @national_insurance_presence_page ||= NationalInsurancePresencePage.new
end

def home_office_page
  @home_office_page ||= HomeOfficePage.new
end

def dob_page
  @dob_page ||= DobPage.new
end

def personal_details_page
  @personal_details_page ||= PersonalDetailsPage.new
end

def address_page
  @address_page ||= AddressPage.new
end

def contact_page
  @contact_page ||= ContactPage.new
end

def apply_type_page
  @apply_type_page ||= ApplyTypePage.new
end

def summary_page
  @summary_page ||= SummaryPage.new
end

def summary_page_error
  @summary_page ||= SummaryPageError.new
end

def confirmation_page
  @confirmation_page ||= ConfirmationPage.new
end

def confirmation_page_refund
  @confirmation_page ||= ConfirmationPageRefund.new
end

def confirmation_done_page
  @confirmation_done_page ||= ConfirmationDonePage.new
end

def base_page
  @base_page ||= BasePage.new
end

def saucelabs_page
  @saucelabs_page ||= SaucelabsPage.new
end

def footer_page
  @footer_page ||= FooterPage.new
end

def cookie_page
  @cookie_page ||= CookiePage.new
end

def home_page
  @home_page ||= HomePage.new
end

def checklist_continue
  base_page.content.checklist_continue_button.click
end

def continue
  base_page.content.continue_button.click
end

def disable_address_lookup
  stub_request(:post, "https://api.os.uk/oauth2/token/v1").
    with(
      body: { "grant_type" => "client_credentials" },
      headers: {
        'Accept' => '*/*',
        'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'Authorization' => 'Basic YXBpX2tleTphcGlfc2VjcmV0',
        'Content-Type' => 'application/x-www-form-urlencoded',
        'User-Agent' => 'Ruby'
      }
    ).
    to_return(status: 200, body: "", headers: {})
end
