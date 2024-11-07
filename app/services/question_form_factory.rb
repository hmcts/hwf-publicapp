class QuestionFormFactory
  class QuestionDoesNotExist < StandardError; end

  def self.page_list
    Settings.navigation
  end

  def self.position(id)
    page_list.index(id)
  end

  def self.get_form(id, calculation_scheme)
    raise QuestionDoesNotExist unless page_list.include?(id)

    class_name = "Forms::#{form_class_name(id)}".constantize
    form = class_name.new
    form.calculation_scheme = calculation_scheme
    form
  end

  def self.form_class_name(id)
    if id == :claim
      'Claim::Default'
    else
      id.to_s.classify
    end
  end
end
