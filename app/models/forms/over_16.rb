module Forms
  class Over16 < Base
    attribute :over_16, Boolean

    validates :over_16, inclusion: { in: [true, false] }

    private

    def export_params
      { over_16: over_16 }
    end
    # override HO/NI and marital status is under 16
  end
end
