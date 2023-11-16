module Forms
  class LegalRepresentative < Base
    attribute :legal_representative, String

    validates :legal_representative, inclusion: { in: ['litigation_friend', 'legal_representative'] }

    private

    def export_params
      {
        legal_representative: legal_representative
      }
    end
  end
end
