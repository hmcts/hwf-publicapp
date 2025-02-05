module Forms
  class Dependent < Base
    include ActiveModel::Validations::Callbacks

    attribute :children, Boolean
    attribute :children_number, Integer
    attribute :children_age_band, Hash
    attribute :children_bands, [String]

    validates :children_number, presence: true, numericality: { less_than: 100, greater_than: -1 }

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

      totals = children_bands.tally
      @children_age_band = { one: totals.fetch('one', 0), two: totals.fetch('two', 0) }
      @children_age_band = { one: 0, two: 0 } if children_number.zero?
    end

    def reset_children_fields
      return if children || children_number

      @children_number = 0
      @children_age_band = nil
    end
  end
end
