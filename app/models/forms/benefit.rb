module Forms
  class Benefit < Base
    attribute :on_benefits, :boolean

    validates :on_benefits, inclusion: { in: [true, false] }

    private

    def export_params
      {
        benefits: on_benefits_value
      }
    end

    def on_benefits_value
      on_benefits.nil? ? false : on_benefits
    end
  end
end
