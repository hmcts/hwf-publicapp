module Forms
  class ApplicantAddress < Base
    attribute :street, String
    attribute :postcode, String
    attribute :town, String

    validates :street, presence: true, sensible_address: true, length: { maximum: 99 }
    validates :postcode, presence: true, sensible_address: true, length: { maximum: 8 }
    validates :town, presence: true, sensible_address: true, length: { maximum: 30 }

    private

    def export_params
      {
        address: address,
        street: street,
        town: town,
        postcode: postcode
      }
    end

    def address
      "#{street}, #{town}"
    end
  end
end
