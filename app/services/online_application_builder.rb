class OnlineApplicationBuilder
  attr_reader :online_application

  def initialize(storage)
    @storage = storage
    build_application
  end

  private

  def build_application
    calculation_scheme = @storage.load_calculation_scheme
    @online_application = OnlineApplication.new
    QuestionFormFactory.page_list(calculation_scheme).each do |question|
      form = QuestionFormFactory.get_form(question, calculation_scheme)
      @storage.load_form(form)
      check_before_override(form)
    end
  end

  def check_before_override(form)
    attributes = form.export

    attributes.each_key do |key|
      next if attributes[key].nil?

      @online_application[key] = attributes[key]
    end
  end
end
