module Forms
  class ApplyingOnBehalf < Base
    attribute :applying_on_behalf, :boolean

    validates :applying_on_behalf, inclusion: { in: [true, false] }

    private

    def export_params
      {
        applying_on_behalf: applying_on_behalf
      }
    end
  end
end
