module Forms
  class Statement < Base
    SIGNED_BY = %w[applicant legal_representative].freeze
    attribute :signed_by, :string

    validates :signed_by, inclusion: { in: %w[applicant legal_representative] }

    private

    def export_params
      {
        statement_signed_by: signed_by
      }
    end
  end
end
