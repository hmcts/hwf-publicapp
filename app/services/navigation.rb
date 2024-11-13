class Navigation
  include Rails.application.routes.url_helpers
  include NavigationHelper

  def initialize(online_application, current_question)
    @online_application = online_application
    @current_question = current_question
  end

  def next
    if last_question? || (@current_question == :contact && skip_apply_type?)
      summary_path(locale: I18n.locale)
    else
      question_path(next_question_id, locale: I18n.locale)
    end
  end

  def page_number
    current_index = QuestionFormFactory.page_list.find_index(@current_question)
    return 0 if current_index.nil?

    current_index + 1
  end

end
