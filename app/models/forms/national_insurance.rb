module Forms
  class NationalInsurance < Base
    include ActiveModel::Validations::Callbacks

    attribute :number, :string
    attribute :ni_number_present, :boolean

    NI_NUMBER_REGEXP = /\A(?!BG|GB|NK|KN|TN|NT|ZZ)[ABCEGHJ-PRSTW-Z][ABCEGHJ-NPRSTW-Z]\d{6}[A-D]\z/

    validates :number, format: { with: NI_NUMBER_REGEXP }, allow_blank: true, unless: lambda { |form|
                                                                                        form.ni_number_present.blank?
                                                                                      }
    validates :number, presence: true, unless: ->(form) { form.ni_number_present.blank? }
    validates :ni_number_present, inclusion: { in: [true, false] }

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
        ni_number: number,
        ni_number_present: ni_number_present
      }
    end
  end
end
