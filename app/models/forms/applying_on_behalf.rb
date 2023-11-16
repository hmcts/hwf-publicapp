module Forms
  class ApplyingOnBehalf < Base
    APPLY_TYPE = %w[paper online].freeze
    attribute :applying_on_behalf, Boolean

    validates :applying_on_behalf, inclusion: { in: [true, false] }

    private

    def export_params
      {
        applying_on_behalf: applying_on_behalf
      }
    end
  end
end
