module Forms
  class LegalRepresentativeDetail < Base
    include ActiveModel::Validations::Callbacks

    attribute :legal_representative_first_name, String
    attribute :legal_representative_last_name, String
    attribute :legal_representative_email, String
    attribute :legal_representative_organisation_name, String
    attribute :legal_representative_feedback_opt_in, Boolean

    attribute :street, String
    attribute :postcode, String
    attribute :town, String

    validates :legal_representative_first_name, presence: true, sensible_name: true, length: { maximum: 49 }
    validates :legal_representative_last_name, presence: true, sensible_name: true, length: { maximum: 49 }
    validates :legal_representative_organisation_name, allow_blank: true, sensible_name: true
    validates :legal_representative_email, presence: true

    before_validation :sanitize_email

    email_regex = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
    validates :legal_representative_email,
              format: { with: email_regex },
              length: { maximum: 99 }

    validates :street, presence: true, sensible_address: true, length: { maximum: 99 }
    validates :postcode, presence: true, sensible_address: true, length: { maximum: 8 }
    validates :town, presence: true, sensible_address: true, length: { maximum: 30 }

    private

    # rubocop:disable Metrics/MethodLength
    def export_params
      {
        legal_representative_address: address,
        legal_representative_street: street,
        legal_representative_town: town,
        legal_representative_postcode: postcode,
        legal_representative_first_name: legal_representative_first_name,
        legal_representative_last_name: legal_representative_last_name,
        legal_representative_email: legal_representative_email,
        legal_representative_organisation_name: legal_representative_organisation_name,
        legal_representative_feedback_opt_in: legal_representative_feedback_opt_in
      }
    end
    # rubocop:enable Metrics/MethodLength

    def address
      "#{street}, #{town}"
    end

    def sanitize_email
      return if legal_representative_email.blank?

      @legal_representative_email = legal_representative_email.strip!
    end
  end
end
