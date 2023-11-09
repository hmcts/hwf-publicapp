class Storage
  class Expired < StandardError; end
  include PageNavigation

  def initialize(session, options = {})
    @session = session
    clear if options[:clear]
    check_expiration!
  end

  def clear
    @session.destroy
    store.write('page_path', [])
  end

  def start
    @session[:started_at] = Time.zone.now
  end

  def save_calculation_scheme(scheme)
    @session[:calculation_scheme] = scheme
  end

  def load_calculation_scheme
    @session[:calculation_scheme]
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

  def clear_forms(form_ids)
    form_ids.each do |form_id|
      clear_form(form_id)
    end
  end

  def submission_result=(result)
    @session[:submission_result] = result
  end

  def submission_result
    @session[:submission_result]
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

end
