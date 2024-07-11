module Forms
  class PartnerNationalInsurance < Base
    include ActiveModel::Validations::Callbacks

    attribute :ni_number, String
    attribute :number, String
    attribute :partner_ni_number_blank, Boolean

    NI_NUMBER_REGEXP = /\A(?!BG|GB|NK|KN|TN|NT|ZZ)[ABCEGHJ-PRSTW-Z][ABCEGHJ-NPRSTW-Z]\d{6}[A-D]\z/

    validates :number, presence: true, unless: ->(form) { form.partner_ni_number_blank }
    validates :number, format: { with: NI_NUMBER_REGEXP }, allow_blank: true

    validate :number_duplicate

    before_validation :format_number

    private

    def number_duplicate
      if number.present? && number == ni_number
        errors.add(:number, :not_duplicate)
      end
    end

    def format_number
      unless number.nil?
        number.upcase!
        number.delete!(' ')
      end
    end

    def export_params
      {
        partner_ni_number: partner_ni_number_blank ? nil : number,
        partner_ni_number_blank: partner_ni_number_blank
      }
    end
  end
end
