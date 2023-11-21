module Forms
  class Dependent < Base
    include ActiveModel::Validations::Callbacks

    attribute :children, Boolean
    attribute :children_number, Integer
    attribute :children_age_band, Hash
    attribute :children_age_band_one, Integer
    attribute :children_age_band_two, Integer

    validates :children, inclusion: { in: [true, false] }
    validates :children_number,
              presence: true, numericality: { less_than: 100, greater_than: 0 }, if: :children

    # POST UCD
    before_validation :reset_children_fields
    before_validation :prepare_children_fields

    private

    def export_params
      {
        children: export_children,
        children_age_band: children_age_band
      }
    end

    def export_children
      if children.nil?
        nil
      elsif children
        children_number
      else
        0
      end
    end

    # POST UCD

    def number_of_children_when_no_dependents
      if children_declared_but_dependents_arent?
        errors.add(
          :children,
          :cant_have_children_assigned
        )
      end
    end

    def children_declared_but_dependents_arent?
      !children && children_number.to_i.positive?
    end

    def prepare_children_fields
      return unless children
      return unless ucd_changes_apply?

      @children_number = band_one_value + band_two_value
      @children_age_band = { one: band_one_value, two: band_two_value }

      if @children_number.zero?
        errors.add(:children_age_band_one, :blank)
        errors.add(:children_age_band_two, :blank)
      end
    end

    def reset_children_fields
      return unless ucd_changes_apply?
      return if children

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

  end
end
