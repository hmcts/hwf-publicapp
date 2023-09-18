class QuestionFormFactory
  class QuestionDoesNotExist < StandardError; end

  # These are ordered
  IDS = %i[
    fee
    form_name
    national_insurance_presence
    national_insurance
    home_office
    marital_status
    savings_and_investment
    savings_and_investment_extra
    benefit
    dependent
    income_kind
    income_range
    income_amount
    probate
    claim
    dob
    personal_detail
    applicant_address
    contact
    apply_type
  ].freeze

  def self.position(id)
    IDS.index(id)
  end

  def self.get_form(id)
    raise QuestionDoesNotExist unless IDS.include?(id)

    class_name = "Forms::#{form_class_name(id)}".constantize
    class_name.new
  end

  def self.form_class_name(id)
    if id == :claim
      'Claim::Default'
    else
      id.to_s.classify
    end
  end
end
