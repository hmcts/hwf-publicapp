def to_address_page(marital_status)
  to_fee_page
  fee_page.submit_fee_yes
  form_name_page.submit_valid_form_number
  applying_on_behalf_page.submit_no
  national_insurance_page.select_yes_and_enter_valid_ni
  if marital_status == 'married'
    marital_status_page.submit_married
    partner_national_insurance_page.submit_no_ni
    savings_investment_page.low_amount_checked
    benefit_page.submit_benefit_yes
    probate_page.submit_probate_no
    claim_page.submit_claim_no
    dob_page.valid_partner_dob
    personal_details_page.submit_full_names
  else
    marital_status_page.submit_single
    savings_investment_page.low_amount_checked
    benefit_page.submit_benefit_yes
    probate_page.submit_probate_no
    claim_page.submit_claim_no
    dob_page.valid_dob
    personal_details_page.submit_full_name
  end
end

def to_benefit_page(marital_status)
  to_fee_page
  fee_page.submit_fee_yes
  form_name_page.submit_valid_form_number
  applying_on_behalf_page.submit_no
  national_insurance_page.select_yes_and_enter_valid_ni
  if marital_status == 'married'
    marital_status_page.submit_married
    partner_national_insurance_page.submit_no_ni
  else
    marital_status_page.submit_single
  end
  savings_investment_page.low_amount_checked
end

def to_claim_page(marital_status)
  to_fee_page
  fee_page.submit_fee_yes
  form_name_page.submit_valid_form_number
  applying_on_behalf_page.submit_no
  national_insurance_page.select_yes_and_enter_valid_ni
  if marital_status == 'married'
    marital_status_page.submit_married
    partner_national_insurance_page.submit_no_ni
  else
    marital_status_page.submit_single
  end
  savings_investment_page.low_amount_checked
  benefit_page.submit_benefit_yes
  probate_page.submit_probate_no
end

def to_confirmation_page(marital_status)
  to_fee_page
  fee_page.submit_fee_no
  form_name_page.submit_valid_form_number
  applying_on_behalf_page.submit_no
  national_insurance_page.select_yes_and_enter_valid_ni
  if marital_status == 'married'
    marital_status_page.submit_married
    partner_national_insurance_page.submit_no_ni
    savings_investment_page.medium_amount_checked
    savings_investment_extra_page.submit_yes
    benefit_page.submit_benefit_no
    dependent_page.submit_dependent_no
    income_kind_page.submit_none_of_the_above_married
    income_period_page.submit_income(1000)
    probate_page.submit_probate_no
    claim_page.submit_claim_no
    dob_page.valid_partner_over_66_dob
    personal_details_page.submit_full_names
  else
    marital_status_page.submit_single
    savings_investment_page.medium_amount_checked
    savings_investment_extra_page.submit_yes
    benefit_page.submit_benefit_no
    dependent_page.submit_dependent_no
    income_kind_page.submit_none_of_the_above
    income_period_page.submit_income(1000)
    probate_page.submit_probate_no
    claim_page.submit_claim_no
    dob_page.valid_over_66_dob
    personal_details_page.submit_full_name
  end
  if Capybara.app_host == 'https://public.demo.hwf.dsd.io'
    address_page.submit_full_address_demo
  else
    address_page.submit_full_address
  end
  contact_page.valid_email
  apply_type_page.applying_by_paper
  summary_page.submit_application
end

def to_online_confirmation_page(marital_status)
  to_fee_page
  fee_page.submit_fee_no
  form_name_page.submit_valid_form_number
  applying_on_behalf_page.submit_no
  national_insurance_page.select_yes_and_enter_valid_ni
  if marital_status == 'married'
    marital_status_page.submit_married
    partner_national_insurance_page.submit_no_ni
    savings_investment_page.medium_amount_checked
    savings_investment_extra_page.submit_yes
    benefit_page.submit_benefit_no
    dependent_page.submit_dependent_no
    income_kind_page.submit_none_of_the_above_married
    income_period_page.submit_income(1000)
    probate_page.submit_probate_no
    claim_page.submit_claim_no
    dob_page.valid_partner_over_66_dob
    personal_details_page.submit_full_names
  else
    marital_status_page.submit_single
    savings_investment_page.medium_amount_checked
    savings_investment_extra_page.submit_yes
    benefit_page.submit_benefit_no
    dependent_page.submit_dependent_no
    income_kind_page.submit_none_of_the_above
    income_period_page.submit_income(1000)
    probate_page.submit_probate_no
    claim_page.submit_claim_no
    dob_page.valid_over_66_dob
    personal_details_page.submit_full_name
  end
  if Capybara.app_host == 'https://public.demo.hwf.dsd.io'
    address_page.submit_full_address_demo
  else
    address_page.submit_full_address
  end
  contact_page.valid_email
  apply_type_page.applying_by_online_service
  summary_page.submit_application
end

def to_contact_page(marital_status)
  to_fee_page
  fee_page.submit_fee_no
  form_name_page.submit_valid_form_number
  applying_on_behalf_page.submit_no
  national_insurance_page.select_yes_and_enter_valid_ni
  if marital_status == 'married'
    marital_status_page.submit_married
    partner_national_insurance_page.submit_no_ni
    savings_investment_page.low_amount_checked
    benefit_page.submit_benefit_yes
    probate_page.submit_probate_no
    claim_page.submit_claim_no
    dob_page.valid_partner_dob
    personal_details_page.submit_full_names
  else
    marital_status_page.submit_single
    savings_investment_page.low_amount_checked
    benefit_page.submit_benefit_yes
    probate_page.submit_probate_no
    claim_page.submit_claim_no
    dob_page.valid_dob
    personal_details_page.submit_full_name
  end
  address_page.submit_full_address
end

def to_dependent_page(marital_status)
  to_fee_page
  fee_page.submit_fee_no
  form_name_page.submit_valid_form_number
  applying_on_behalf_page.submit_no
  national_insurance_page.select_yes_and_enter_valid_ni
  if marital_status == 'married'
    marital_status_page.submit_married
    partner_national_insurance_page.submit_no_ni
  else
    marital_status_page.submit_single
  end
  savings_investment_page.low_amount_checked
  benefit_page.submit_benefit_no
end

def to_dob_page(marital_status)
  to_fee_page
  fee_page.submit_fee_no
  form_name_page.submit_valid_form_number
  applying_on_behalf_page.submit_no
  national_insurance_page.select_yes_and_enter_valid_ni
  if marital_status == 'married'
    marital_status_page.submit_married
    partner_national_insurance_page.submit_no_ni
  else
    marital_status_page.submit_single
  end
  savings_investment_page.low_amount_checked
  benefit_page.submit_benefit_yes
  probate_page.submit_probate_no
  claim_page.submit_claim_no
end

def to_fee_page
  checklist_page.load_page
  checklist_continue
end

def to_home_office_page
  to_fee_page
  fee_page.submit_fee_no
  form_name_page.submit_valid_form_number
  applying_on_behalf_page.submit_no
  national_insurance_page.submit_no
end

def to_income_kind(marital_status)
  to_fee_page
  fee_page.submit_fee_yes
  form_name_page.submit_valid_form_number
  applying_on_behalf_page.submit_no
  national_insurance_page.select_yes_and_enter_valid_ni
  if marital_status == 'married'
    marital_status_page.submit_married
    partner_national_insurance_page.submit_no_ni
  else
    marital_status_page.submit_single
  end
  savings_investment_page.high_amount_checked
  benefit_page.submit_benefit_no
  dependent_page.submit_dependent_3
end

def to_marital_status
  to_fee_page
  fee_page.submit_fee_yes
  form_name_page.submit_valid_form_number
  applying_on_behalf_page.submit_no
  national_insurance_page.select_yes_and_enter_valid_ni
end

def to_apply_on_behalf_page
  to_fee_page
  fee_page.submit_fee_yes
  form_name_page.submit_valid_form_number
end

def to_national_insurance_page
  to_fee_page
  fee_page.submit_fee_yes
  form_name_page.submit_valid_form_number
  applying_on_behalf_page.submit_no
end

def to_personal_details_page(marital_status)
  to_fee_page
  fee_page.submit_fee_yes
  form_name_page.submit_valid_form_number
  applying_on_behalf_page.submit_no
  national_insurance_page.select_yes_and_enter_valid_ni
  if marital_status == 'married'
    marital_status_page.submit_married
    partner_national_insurance_page.submit_no_ni
    savings_investment_page.low_amount_checked
    benefit_page.submit_benefit_yes
    probate_page.submit_probate_no
    claim_page.submit_claim_no
    dob_page.valid_partner_dob
  else
    marital_status_page.submit_single
    savings_investment_page.low_amount_checked
    benefit_page.submit_benefit_yes
    probate_page.submit_probate_no
    claim_page.submit_claim_no
    dob_page.valid_dob
  end
end

def to_probate_page(marital_status)
  to_fee_page
  fee_page.submit_fee_yes
  form_name_page.submit_valid_form_number
  applying_on_behalf_page.submit_no
  national_insurance_page.select_yes_and_enter_valid_ni
  if marital_status == 'married'
    marital_status_page.submit_married
    partner_national_insurance_page.submit_no_ni
  else
    marital_status_page.submit_single
  end
  savings_investment_page.low_amount_checked
  benefit_page.submit_benefit_yes
end

def to_savings_extra(marital_status)
  to_fee_page
  fee_page.submit_fee_yes
  form_name_page.submit_valid_form_number
  applying_on_behalf_page.submit_no
  national_insurance_page.select_yes_and_enter_valid_ni
  if marital_status == 'married'
    marital_status_page.submit_married
    partner_national_insurance_page.submit_no_ni
  else
    marital_status_page.submit_single
  end
  savings_investment_page.medium_amount_checked
end

def to_savings(marital_status)
  to_fee_page
  fee_page.submit_fee_yes
  form_name_page.submit_valid_form_number
  applying_on_behalf_page.submit_no
  national_insurance_page.select_yes_and_enter_valid_ni
  if marital_status == 'married'
    marital_status_page.submit_married
    partner_national_insurance_page.submit_no_ni
  else
    marital_status_page.submit_single
  end
end

def to_summary_page_probate_enabled(marital_status)
  to_fee_page
  fee_page.submit_fee_no
  form_name_page.submit_valid_form_number
  applying_on_behalf_page.submit_no
  national_insurance_page.select_yes_and_enter_valid_ni
  if marital_status == 'married'
    marital_status_page.submit_married
    partner_national_insurance_page.submit_no_ni
  else
    marital_status_page.submit_single
  end
  savings_investment_page.medium_amount_checked
  savings_investment_extra_page.submit_yes
  benefit_page.submit_benefit_no
  dependent_page.submit_dependent_no
  income_kind_page.submit_none_of_the_above
  income_period_page.submit_income(1000)
  probate_page.submit_probate_no
  claim_page.submit_claim_no
  if marital_status == 'married'
    dob_page.valid_partner_over_66_dob
    personal_details_page.submit_full_names
  else
    dob_page.valid_over_66_dob
    personal_details_page.submit_full_name
  end
  address_page.submit_full_address
  contact_page.valid_email
  apply_type_page.applying_by_paper
end

def to_summary_page_probate_disabled(marital_status)
  to_fee_page
  fee_page.submit_fee_no
  form_name_page.submit_valid_form_number
  applying_on_behalf_page.submit_no
  national_insurance_page.select_yes_and_enter_valid_ni
  if marital_status == 'married'
    marital_status_page.submit_married
    partner_national_insurance_page.submit_no_ni
    savings_investment_page.low_amount_checked
    benefit_page.submit_benefit_yes
    claim_page.submit_claim_no
    dob_page.static_dobs
    personal_details_page.submit_full_names
  else
    marital_status_page.submit_single
    savings_investment_page.low_amount_checked
    benefit_page.submit_benefit_yes
    claim_page.submit_claim_no
    dob_page.static_dob
    personal_details_page.submit_full_name
  end
  address_page.submit_full_address
  contact_page.valid_email
  apply_type_page.applying_by_paper
end

def to_summary_page_probate_enabled_fee_paid(marital_status)
  to_fee_page
  fee_page.submit_fee_yes
  form_name_page.submit_valid_form_number
  applying_on_behalf_page.submit_no
  national_insurance_page.select_yes_and_enter_valid_ni
  if marital_status == 'married'
    marital_status_page.submit_married
    partner_national_insurance_page.submit_no_ni
    savings_investment_page.medium_amount_checked
    savings_investment_extra_page.submit_yes
    benefit_page.submit_benefit_no
    dependent_page.submit_dependent_no
    income_kind_page.submit_none_of_the_above_married
    income_period_page.submit_income(0)
    probate_page.submit_probate_no
    claim_page.submit_claim_no
    dob_page.valid_partner_over_66_dob
    personal_details_page.submit_full_names
  else
    marital_status_page.submit_single
    savings_investment_page.medium_amount_checked
    savings_investment_extra_page.submit_yes
    benefit_page.submit_benefit_no
    dependent_page.submit_dependent_no
    income_kind_page.submit_none_of_the_above
    income_period_page.submit_income(0)
    probate_page.submit_probate_no
    claim_page.submit_claim_no
    dob_page.valid_over_66_dob
    personal_details_page.submit_full_name
  end
  address_page.submit_full_address
  contact_page.valid_email
end

def to_summary_page_with_ni_number
  national_insurance_page.select_yes_and_enter_valid_ni
  marital_status_page.submit_married
  partner_national_insurance_page.submit_no_ni
  savings_investment_page.low_amount_checked
  benefit_page.submit_benefit_no
  dependent_page.submit_dependent_no
  income_kind_page.submit_none_of_the_above_married
  income_period_page.submit_income(0)
  probate_page.submit_probate_no
  dob_page.static_dobs
  personal_details_page.submit_full_names
  address_page.submit_full_address
  contact_page.valid_email
  apply_type_page.applying_by_paper
end

def to_summary_page_with_ho_number(marital_status)
  national_insurance_page.submit_no
  home_office_page.submit_valid_home_office_number
  if marital_status == 'married'
    marital_status_page.submit_married
    savings_investment_page.low_amount_checked
    dependent_page.submit_dependent_no
    income_kind_page.submit_none_of_the_above_married
  else
    marital_status_page.submit_single
    savings_investment_page.low_amount_checked
    dependent_page.submit_dependent_no
    income_kind_page.submit_none_of_the_above
  end
  income_period_page.submit_income(0)
  probate_page.submit_probate_no
  dob_page.static_dob
  personal_details_page.submit_full_name
  address_page.submit_full_address
  contact_page.valid_email
  apply_type_page.applying_by_paper
end
