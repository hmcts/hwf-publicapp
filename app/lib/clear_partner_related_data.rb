module ClearPartnerRelatedData

  def clear_partner_data
    clear_partner_income_kind
    clear_partner_dob
    clear_partner_name
    clear_partner_ni
  end

  private

  def clear_partner_income_kind
    form = Forms::IncomeKind.new
    income_kind_attributes = @storage.load_form(form)
    income_kind_attributes.delete('partner')
    form = Forms::IncomeKind.new(income_kind_attributes)
    @storage.save_form(form)
  end

  def clear_partner_dob
    form = Forms::Dob.new
    form_attributes = @storage.load_form(form)
    form_attributes.delete('partner_day')
    form_attributes.delete('partner_month')
    form_attributes.delete('partner_year')
    form = Forms::Dob.new(form_attributes)
    @storage.save_form(form)
  end

  def clear_partner_name
    form = Forms::PersonalDetail.new
    form_attributes = @storage.load_form(form)
    form_attributes.delete('partner_first_name')
    form_attributes.delete('partner_last_name')
    form = Forms::PersonalDetail.new(form_attributes)
    @storage.save_form(form)
  end

  def clear_partner_ni
    form = Forms::PartnerNationalInsurance.new
    form_attributes = @storage.load_form(form)
    form_attributes.delete('partner_ni_number_blank')
    form_attributes.delete('number')
    form = Forms::PartnerNationalInsurance.new(form_attributes)
    @storage.save_form(form)
  end
end
