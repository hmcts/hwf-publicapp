module Forms
  class LegalRepresentative < Base
    attribute :legal_representative, String

    validates :legal_representative, inclusion: { in: %w[litigation_friend legal_representative] }

    private

    # TODO: reset data if legal rep answer is changed

    def export_params
      {
        legal_representative: legal_representative
      }
    end
  end
end
