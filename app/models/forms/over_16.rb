module Forms
  class Over16 < Base
    attribute :over_16, Boolean
    attribute :married, Boolean

    validates :over_16, inclusion: { in: [true, false] }

    private

    def export_params
      return { over_16: over_16 } if over_16 || over_16.nil?
      {
        over_16: over_16,
        married: false,
        ni_number_present: false
      }
    end
    # override HO/NI and marital status is under 16
  end
end
