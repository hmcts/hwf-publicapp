module Forms
  class ApplyType < Base
    APPLY_TYPE = %w[paper online].freeze
    attribute :applying_method, String

    validates :applying_method, inclusion: { in: %w[paper online] }

    private

    def export_params
      {
        applying_method: applying_method
      }
    end
  end
end
