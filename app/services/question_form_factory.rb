class QuestionFormFactory
  include FeatureSwitch
  class QuestionDoesNotExist < StandardError; end

  def self.page_list(calculation_scheme = '')
    if FeatureSwitch.ucd_changes_apply?(calculation_scheme)
      Settings.navigation.post_ucd_changes
    elsif FeatureSwitch.active?('ucd_refactor')
      Settings.navigation.pre_ucd_changes
    else
      Settings.navigation.old_default
    end
  end

  def self.position(id)
    page_list.index(id)
  end

  def self.get_form(id, calculation_scheme)
    raise QuestionDoesNotExist unless page_list(calculation_scheme).include?(id)

    class_name = "Forms::#{form_class_name(id)}".constantize
    class_name.new
  end

  def self.form_class_name(id)
    if id == :claim
      'Claim::Default'
    else
      id.to_s.classify
    end
  end
end
