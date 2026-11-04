module Views
  # Answers that a changed earlier answer made necessary but the user has not given yet.
  module MissingAnswers
    CHECKS = {
      ho_number: :ho_number_missing?,
      benefits: :benefits_missing?,
      partner_ni_number: :partner_ni_number_missing?,
      partner_date_of_birth: :partner_date_of_birth_missing?,
      partner_name: :partner_name_missing?
    }.freeze

    def missing_answers
      @missing_answers ||= CHECKS.select { |_answer, check| send(check) }.keys
    end

    def missing_answer?(answer)
      missing_answers.include?(answer)
    end

    def incomplete?
      income_validation_fails? || missing_answers.any?
    end

    def partner_details_required?
      display_ni? && married == true && ni_number_present == true
    end

    private

    def ho_number_missing?
      display_ni? && ni_number_present == false && ho_number.blank?
    end

    def benefits_missing?
      display_benefits? && !@benefit_answered
    end

    def partner_ni_number_missing?
      partner_details_required? && partner_ni_number.blank? && !partner_ni_number_blank
    end

    def partner_date_of_birth_missing?
      partner_details_required? && partner_date_of_birth.nil?
    end

    def partner_name_missing?
      partner_details_required? && (partner_first_name.blank? || partner_last_name.blank?)
    end
  end
end
