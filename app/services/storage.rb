class Storage
  class Expired < StandardError; end
  include PageNavigation

  # All keys are scoped by the cookie session id AND the application id from
  # the URL, so several applications can run side by side in one browser while
  # a copied URL stays useless in any other browser.
  def initialize(session, app_id, options = {})
    @session = session
    @app_id = app_id
    clear if options[:clear]
    check_expiration!
  end

  def clear
    clear_redis
    rails_store.delete(metadata_key)
    @metadata = {}
  end

  def start
    write_metadata(started_at: Time.zone.now)
  end

  def save_calculation_scheme(scheme)
    write_metadata(calculation_scheme: scheme)
  end

  def load_calculation_scheme
    metadata[:calculation_scheme]
  end

  def started?
    metadata[:started_at].present?
  end

  def rails_store
    Rails.cache
  end

  def save_form(form)
    # Expire cached answers after the session lifetime so abandoned sessions
    # do not leave keys in Redis forever.
    rails_store.write(form_key(form.id), form.as_json, expires_in: expires_in_seconds)
  end

  def load_form(form)
    params = rails_store.read(form_key(form.id)) || {}
    form.update_attributes(params)
  end

  def clear_form(form_id)
    rails_store.delete(form_key(form_id))
  end

  def clear_forms(form_ids)
    form_ids.each do |form_id|
      clear_form(form_id)
    end
  end

  def submission_result=(result)
    # Stored as_json (string keys), matching how the JSON cookie session used
    # to serialise it — the confirmation views read @result['message'].
    write_metadata(submission_result: result.as_json)
  end

  def submission_result
    metadata[:submission_result]
  end

  private

  def check_expiration!
    if started? && expired?
      clear
      raise Expired
    else
      update_last_used
    end
  end

  def update_last_used
    # Writing to the cookie session on every request keeps it dirty, so the
    # browser keeps a stable session id — which scopes every Redis key.
    @session[:used_at] = Time.zone.now
    write_metadata(used_at: Time.zone.now) if started?
  end

  def expired?
    used_at && ((Time.zone.now - used_at).round >= expires_in_seconds)
  end

  def used_at
    field_as_time(:used_at)
  end

  def field_as_time(field)
    metadata[field].is_a?(String) ? Time.zone.parse(metadata[field]) : metadata[field]
  end

  def expires_in_seconds
    Settings.session.expires_in_minutes * 60
  end

  def metadata
    @metadata ||= rails_store.read(metadata_key) || {}
  end

  def write_metadata(attrs)
    @metadata = metadata.merge(attrs)
    # Kept for twice the session lifetime so check_expiration! can still tell
    # "expired" (show the expiry message) from "never started" after the hour.
    rails_store.write(metadata_key, @metadata, expires_in: expires_in_seconds * 2)
  end

  def metadata_key
    "metadata-#{@session.id}-#{@app_id}"
  end

  def form_key(form_id)
    "questions-#{@session.id}-#{@app_id}-#{form_id}"
  end

  def clear_redis
    if load_calculation_scheme
      form_ids = QuestionFormFactory.page_list
      clear_forms(form_ids)
    end
  end

end
