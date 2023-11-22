class OnlineApplication
  include Virtus.model(nullify_blank: true)

  attribute :married, Boolean
  attribute :min_threshold_exceeded, Boolean
  attribute :max_threshold_exceeded, Boolean
  attribute :over_61, Boolean
  attribute :amount, Integer
  attribute :benefits, Boolean
  attribute :children, Integer
  attribute :children_age_band, Hash
  attribute :income_min_threshold_exceeded, Boolean
  attribute :income_max_threshold_exceeded, Boolean
  attribute :income, Integer
  attribute :income_kind, Hash
  attribute :refund, Boolean
  attribute :date_fee_paid, Date
  attribute :probate, Boolean
  attribute :deceased_name, String
  attribute :date_of_death, Date
  attribute :case_number, String
  attribute :form_name, String
  attribute :ni_number_present, Boolean
  attribute :ni_number, String
  attribute :ho_number, String
  attribute :date_of_birth, Date
  attribute :partner_date_of_birth, Date
  attribute :title, String
  attribute :first_name, String
  attribute :last_name, String
  attribute :partner_first_name, String
  attribute :partner_last_name, String
  attribute :address, String
  attribute :street, String
  attribute :town, String
  attribute :postcode, String
  attribute :email_contact, Boolean
  attribute :email_address, String
  attribute :phone_contact, Boolean
  attribute :phone, String
  attribute :post_contact, Boolean
  attribute :feedback_opt_in, Boolean
  attribute :applying_method, String
  attribute :calculation_scheme, String
  attribute :applying_on_behalf, Boolean
  attribute :legal_representative, String
  attribute :legal_representative_first_name, String
  attribute :legal_representative_last_name, String
  attribute :legal_representative_email, String
  attribute :legal_representative_organisation_name, String
  attribute :legal_representative_feedback_opt_in, Boolean
  attribute :legal_representative_street, String
  attribute :legal_representative_postcode, String
  attribute :legal_representative_town, String
  attribute :legal_representative_address, String
  attribute :over_16, Boolean
  attribute :statement_signed_by, String

  def full_name
    %i[title first_name last_name].filter_map { |field| send(field) }.join(' ')
  end

  def legal_full_name
    %i[legal_representative_first_name legal_representative_last_name].filter_map { |field| send(field) }.join(' ')
  end

  def legal_full_address
    %i[legal_representative_street legal_representative_town legal_representative_postcode].filter_map do |field|
      send(field)
    end.join(' ')
  end

  def partner_full_name
    %i[partner_first_name partner_last_name].filter_map { |field| send(field) }.join(' ')
  end

  def savings_and_investment_extra_required?
    min_threshold_exceeded? && !max_threshold_exceeded?
  end
end
