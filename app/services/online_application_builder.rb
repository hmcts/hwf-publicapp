class OnlineApplicationBuilder
  attr_reader :online_application

  def initialize(storage)
    @storage = storage
    build_application
  end

  private

  def build_application
    @online_application = OnlineApplication.new

    QuestionFormFactory::IDS.each do |question|
      form = QuestionFormFactory.get_form(question)
      @storage.load_form(form)
      @online_application.attributes = form.export
    end
  end
end
