module FeatureSwitch
  # enabled attribute is false as default

  def self.active?(_method_name, _office = nil)
    list = Settings.feature_switching.map(&:to_hash)
    feature = list.find { |element| element[:feature_key] == "ucd_refactor" && element[:enabled] == true }
    # feature = feature.where('activation_time <= ? OR activation_time IS NULL', Time.zone.now)

    feature.present?
  end
end
