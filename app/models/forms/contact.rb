module Forms
  class Contact < Base
    attribute :email, String
    attribute :feedback_opt_in, Boolean, default: false

    email_regex = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
    validates :email,
              format: { with: email_regex, allow_blank: true },
              length: { maximum: 99 }
    validates :feedback_opt_in, inclusion: { in: [true, false] }

    validate :feedback_when_no_email

    private

    def feedback_when_no_email
      return if feedback_opt_in == false

      errors.add(:email, :feedback_with_no_email) unless email.blank?
    end

    def export_params
      trim_whitespace
      {
        email_contact: email.present?,
        email_address: email,
        phone_contact: false,
        post_contact: false,
        feedback_opt_in: feedback_opt_in
      }
    end

    def trim_whitespace
      self.email = email.strip if email
    end
  end
end
