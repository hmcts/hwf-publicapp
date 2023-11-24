module Forms
  class PartnerNationalInsurance < Base
    include ActiveModel::Validations::Callbacks

    attribute :number, String
    attribute :partner_ni_number_present, Boolean

    NI_NUMBER_REGEXP = /\A(?!BG|GB|NK|KN|TN|NT|ZZ)[ABCEGHJ-PRSTW-Z][ABCEGHJ-NPRSTW-Z]\d{6}[A-D]\z/

    validates :number, format: { with: NI_NUMBER_REGEXP }, allow_blank: true
    validates :number, presence: true, unless: ->(form) { form.partner_ni_number_present.blank? }
    validates :partner_ni_number_present, inclusion: { in: [true, false] }

    before_validation :format_number

    private

    def format_number
      unless number.nil?
        number.upcase!
        number.delete!(' ')
      end
    end

    def export_params
      {
        partner_ni_number: number,
        partner_ni_number_present: partner_ni_number_present
      }
    end
  end
end
