class Storage
  class Expired < StandardError; end

  def initialize(session, options = {})
    @session = session
    @session[:page_path] ||= []
    clear if options[:clear]
    check_expiration!
  end

  def clear
    @session.destroy
  end

  def start
    @session[:started_at] = Time.zone.now
  end

  def started?
    @session[:started_at].present?
  end

  def save_form(form)
    @session['questions'] = {} unless @session['questions']
    @session['questions'][form.id] = form.as_json
  end

  def load_form(form)
    params = @session['questions'] ? (@session['questions'][form.id] || {}) : {}
    form.update_attributes(params)
  end

  def clear_form(form_id)
    @session['questions']&.delete(form_id.to_s)
  end

  def submission_result=(result)
    @session[:submission_result] = result
  end

  def submission_result
    @session[:submission_result]
  end

  def store_page_path(page_url, page_name)
    # temp fix for ActionDispatch::Cookies::CookieOverflow in rspec
    return if Rails.env.test?

    @session[:page_path] << { page_name => page_url }
  end

  def load_step_back(question)
    if @session[:page_path].present? && @session[:page_path].last.key?(question.to_s)
      @session[:page_path].pop
    elsif (page_index = find_page_index(question)).positive?
      @session[:page_path].slice!(page_index, @session[:page_path].count)
    end

    back_link
  end

  private

  def check_expiration!
    if started? && expired?
      clear
      raise Expired
    else
      @session[:used_at] = Time.zone.now
    end
  end

  def expired?
    @session[:used_at] && ((Time.zone.now - used_at).round >= expires_in_seconds)
  end

  def used_at
    field_as_time(:used_at)
  end

  def started_at
    field_as_time(:started_at)
  end

  def field_as_time(field)
    @session[field].is_a?(String) ? Time.zone.parse(@session[field]) : @session[field]
  end

  def expires_in_seconds
    Settings.session.expires_in_minutes * 60
  end

  def find_page_index(question)
    @session[:page_path].each_with_index do |page, page_index|
      key = page.keys.first
      return page_index if key == question.to_s
    end
    0
  end

  def back_link
    return nil if @session[:page_path].blank?

    @session[:page_path].last.values.last
  end

end
