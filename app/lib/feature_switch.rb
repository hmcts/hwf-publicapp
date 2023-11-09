module FeatureSwitch
  NEW_BAND_CALCUATIONS_ACTIVE_DATE = DateTime.parse(Settings.legislation_work.active_date).freeze
  CALCULATION_SCHEMAS = [:prior_q4_23, :q4_23].freeze

  def self.active?(_method_name, _office = nil)
    list = Settings.feature_switching.map(&:to_hash)
    feature = list.find { |element| element[:feature_key] == "ucd_refactor" && element[:enabled] == true }

    feature.present?
  end

  def self.subject_to_new_legislation?(received_and_refund_data)
    return false if correct_dates(received_and_refund_data)

    if received_and_refund_data[:refund]
      received_and_refund_data[:date_fee_paid] >= NEW_BAND_CALCUATIONS_ACTIVE_DATE
    else
      received_and_refund_data[:date_received] >= NEW_BAND_CALCUATIONS_ACTIVE_DATE
    end
  end

  def self.ucd_changes_apply?(calculation_scheme)
    calculation_scheme == FeatureSwitching::CALCULATION_SCHEMAS[1]
  end

  def self.correct_dates(data)
    data[:date_received].blank? || !data[:date_received].is_a?(Date) ||
      (data[:refund] && !data[:date_fee_paid].is_a?(Date))
  end

end


