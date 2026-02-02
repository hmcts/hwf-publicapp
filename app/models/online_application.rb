class OnlineApplication
  include ActiveModel::Model
  include ActiveModel::Attributes
  include ActiveModel::Serializers::JSON
  include NullifyBlank

  attribute :married, :boolean
  attribute :min_threshold_exceeded, :boolean
  attribute :max_threshold_exceeded, :boolean
  attribute :over_66, :boolean
  attribute :amount, :integer
  attribute :benefits, :boolean
  attribute :children, :integer
  attribute :children_age_band, :hash_value
  attribute :income_min_threshold_exceeded, :boolean
  attribute :income_max_threshold_exceeded, :boolean
  attribute :income, :integer
  attribute :income_kind, :hash_value
  attribute :refund, :boolean
  attribute :date_fee_paid, :date
  attribute :probate, :boolean
  attribute :deceased_name, :string
  attribute :date_of_death, :date
  attribute :case_number, :string
  attribute :form_name, :string
  attribute :ni_number_present, :boolean
  attribute :ni_number, :string
  attribute :partner_ni_number, :string
  attribute :partner_ni_number_blank, :boolean
  attribute :ho_number, :string
  attribute :date_of_birth, :date
  attribute :partner_date_of_birth, :date
  attribute :title, :string
  attribute :first_name, :string
  attribute :last_name, :string
  attribute :partner_first_name, :string
  attribute :partner_last_name, :string
  attribute :address, :string
  attribute :street, :string
  attribute :town, :string
  attribute :postcode, :string
  attribute :email_contact, :boolean
  attribute :email_address, :string
  attribute :phone_contact, :boolean
  attribute :phone, :string
  attribute :post_contact, :boolean
  attribute :feedback_opt_in, :boolean
  attribute :applying_method, :string
  attribute :calculation_scheme, :string
  attribute :applying_on_behalf, :boolean
  attribute :legal_representative, :string
  attribute :legal_representative_first_name, :string
  attribute :legal_representative_last_name, :string
  attribute :legal_representative_email, :string
  attribute :legal_representative_organisation_name, :string
  attribute :legal_representative_feedback_opt_in, :boolean
  attribute :legal_representative_street, :string
  attribute :legal_representative_postcode, :string
  attribute :legal_representative_town, :string
  attribute :legal_representative_address, :string
  attribute :legal_representative_position, :string
  attribute :over_16, :boolean
  attribute :statement_signed_by, :string
  attribute :income_period, :string
  attribute :reference_confirm, :boolean

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
