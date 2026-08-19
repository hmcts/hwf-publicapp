class Navigation
  include Rails.application.routes.url_helpers
  include NavigationHelper

  def initialize(online_application, current_question, app_id = nil)
    @online_application = online_application
    @current_question = current_question
    @app_id = app_id
  end

  def next
    if last_question? || (@current_question == :contact && skip_apply_type?)
      summary_path(locale: I18n.locale, app_id: @app_id)
    else
      question_path(next_question_id, locale: I18n.locale, app_id: @app_id)
    end
  end

  def page_number
    current_index = QuestionFormFactory.page_list.find_index(@current_question)
    return 0 if current_index.nil?

    current_index + 1
  end

end
