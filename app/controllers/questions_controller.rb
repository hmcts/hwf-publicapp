class QuestionsController < ApplicationController
  include AddressLookup

  rescue_from QuestionFormFactory::QuestionDoesNotExist, with: :not_found
  before_action :redirect_if_storage_unstarted
  after_action :suppress_browser_cache
  before_action :address_lookup_access_token

  def edit
    assign_title_view
    assign_page_number
    storage.load_form(form)
    load_previous_step
  end

  def update
    form.update_attributes(form_params)

    if form.valid?
      track_step
      process_form_and_online_application
      redirect_to(Navigation.new(online_application, question).next)
    else
      reload_edit_page
      render :edit
    end
  end

  private

  def track_step
    @storage.store_page_path(question_path(question, locale: I18n.locale), question)
  end

  def load_previous_step
    previous_step = @storage.load_step_back(question)
    @previous_step = previous_step.nil? ? checklist_url : previous_step
  end

  def question
    @question ||= params[:id].to_sym
  end

  def form
    @form ||= QuestionFormFactory.get_form(question, calculation_scheme)
  end

  # rubocop:disable Metrics/AbcSize
  def form_params
    if @form.id == "dependent"
      params.require(@form.id).permit(*@form.permitted_attributes, children_bands: []).to_h
    elsif @form.id == "income_kind"
      params.require(@form.id).permit(*@form.permitted_attributes, :children).to_h
    else
      params.require(@form.id).permit(*@form.permitted_attributes).to_h
    end
  end
  # rubocop:enable Metrics/AbcSize

  def process_form_and_online_application
    old_online_application = online_application.dup
    storage.save_form(form)
    storage.save_calculation_scheme(online_application.calculation_scheme)
    online_application.attributes = form.export
    clear_service.for_changes(old_online_application, online_application)
  end

  def clear_service
    ClearDownstreamQuestions.new(storage, question)
  end

  def assign_title_view
    @title_view = Views::QuestionTitle.new(form, online_application)
  end

  def not_found
    render file: 'public/404.html', status: :not_found, layout: false
  end

  def assign_page_number
    @page_number = Navigation.new(online_application, question).page_number
  end

  def address_lookup_access_token
    AddressLookup.access_token(question)
  end

  def reload_edit_page
    load_previous_step
    assign_title_view
    assign_page_number
  end

  def calculation_scheme
    storage.load_calculation_scheme
  end

end
