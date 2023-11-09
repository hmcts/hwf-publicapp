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
      @online_application.attributes = form.export
    end
  end
end
