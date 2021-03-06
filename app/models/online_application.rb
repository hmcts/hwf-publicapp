class OnlineApplication
  include Virtus.model(nullify_blank: true)

  attribute :married, Boolean
  attribute :min_threshold_exceeded, Boolean
  attribute :max_threshold_exceeded, Boolean
  attribute :over_61, Boolean
  attribute :amount, Integer
  attribute :benefits, Boolean
  attribute :children, Integer
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
  attribute :title, String
  attribute :first_name, String
  attribute :last_name, String
  attribute :address, String
  attribute :postcode, String
  attribute :email_contact, Boolean
  attribute :email_address, String
  attribute :phone_contact, Boolean
  attribute :phone, String
  attribute :post_contact, Boolean
  attribute :feedback_opt_in, Boolean

  def full_name
    %i[title first_name last_name].map { |field| send(field) }.compact.join(' ')
  end

  def savings_and_investment_extra_required?
    min_threshold_exceeded? && !max_threshold_exceeded?
  end
end
