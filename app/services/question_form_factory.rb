class QuestionFormFactory
  include FeatureSwitch
  class QuestionDoesNotExist < StandardError; end

  def self.page_list
    if FeatureSwitch.active?('ucd_refactor')
      Settings.navigation.ucd_refactor
    else
      Settings.navigation.default
    end
  end

  def self.position(id)
    page_list.index(id)
  end

  def self.get_form(id)
    raise QuestionDoesNotExist unless page_list.include?(id)

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
