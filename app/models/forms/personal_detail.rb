module Forms
  class PersonalDetail < Base
    attribute :title, String
    attribute :first_name, String
    attribute :last_name, String
    attribute :partner_first_name, String
    attribute :partner_last_name, String
    attribute :is_married, Boolean
    attribute :ni_number_present, Boolean

    validates :title, length: { maximum: 9 }
    validates :first_name, presence: true, sensible_name: true, length: { maximum: 49 }
    validates :last_name, presence: true, sensible_name: true, length: { maximum: 49 }
    validates :partner_first_name, presence: true, sensible_name: true, length: { maximum: 49 },
                                   if: -> { is_married? && ni_number_present }

    validates :partner_last_name, presence: true, sensible_name: true, length: { maximum: 49 },
                                  if: -> { is_married? && ni_number_present }

    private

    def export_params
      trim_whitespace
      details = applicant_name

      if is_married?
        details[:partner_first_name] = partner_first_name
        details[:partner_last_name] = partner_last_name
      end
      details
    end

    def applicant_name
      {
        title: title,
        first_name: first_name,
        last_name: last_name
      }
    end

    def trim_whitespace
      self.first_name = first_name.strip if first_name
      self.last_name = last_name.strip if last_name
      self.partner_first_name = partner_first_name.strip if partner_first_name
      self.partner_last_name = partner_last_name.strip if partner_last_name
    end

  end
end
