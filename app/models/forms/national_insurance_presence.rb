module Forms
  class NationalInsurancePresence < Base
    include ActiveModel::Validations::Callbacks

    attribute :ni_number_present, Boolean

    validates :ni_number_present, inclusion: { in: [true, false] }

    private

    def export_params
      {
        ni_number_present: ni_number_present
      }
    end
  end
end
