module Forms
  module Claim
    class Et < Forms::Base
      attribute :identifier, String

      validates :identifier, presence: true, sensible_identifier: true, length: { maximum: 24 }

      private

      def export_params
        {
          case_number: identifier,
          probate: false
        }
      end
    end

  end
end
