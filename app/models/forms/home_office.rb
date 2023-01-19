module Forms
  class HomeOffice < Base
    include ActiveModel::Validations::Callbacks

    attribute :ho_number, String
    attribute :ni_number_present, Boolean

    HO_NUMBER_REGEXP = %r{\A([a-zA-Z]\d{7}|\d{4}-\d{4}-\d{4}-\d{4})(/\d{1,})?\z}

    validates :ho_number, presence: true, if: ->(form) { form.ni_number_present != true }
    validates :ho_number, format: { with: HO_NUMBER_REGEXP }, allow_blank: true

    before_validation :format_number

    private

    def format_number
      unless ho_number.nil?
        ho_number.upcase!
        ho_number.delete!(' ')
      end
    end

    def export_params
      {
        ho_number: ho_number
      }
    end
  end
end
