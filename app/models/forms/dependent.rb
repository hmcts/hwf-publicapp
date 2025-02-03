module Forms
  class Dependent < Base
    include ActiveModel::Validations::Callbacks

    attribute :children, Boolean
    attribute :children_number, Integer
    attribute :children_age_band, Hash
    attribute :children_age_band_one, Integer
    attribute :children_age_band_two, Integer
    attribute :children_bands, Array[String]

    validates :children_number, presence: true, numericality: { less_than: 100, greater_than: -1 }

    before_validation :sanitize_children_age_band
    before_validation :reset_children_fields
    before_validation :prepare_children_fields

    private

    def export_params
      {
        children: children_number,
        children_age_band: children_age_band
      }
    end

    def prepare_children_fields
      return unless children || children_number
      return unless calculation_scheme == Rails.configuration.ucd_schema.to_s
      # @children_age_band = { one: band_one_value, two: band_two_value }
    end

    def reset_children_fields
      return if children || children_number

      @children_number = 0
      @children_age_band = nil
    end

    def band_one_value
      return 0 if children_age_band_one.blank?

      children_age_band_one
    end

    def band_two_value
      return 0 if children_age_band_two.blank?

      children_age_band_two
    end

    def sanitize_children_age_band
      if children_age_band_one.is_a?(String)
        @children_age_band_one = children_age_band_one.to_i
      end
      if children_age_band_two.is_a?(String)
        @children_age_band_two = children_age_band_two.to_i
      end
    end

  end
end
