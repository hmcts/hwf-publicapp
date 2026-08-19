class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :show_maintenance_page

  rescue_from Storage::Expired, with: :expired_redirect

  before_action :set_locale

  # Journey URLs are scoped by an application id so several applications can
  # run side by side in one browser; anything with a valid id in the URL keeps
  # propagating it through generated links and redirects.
  APP_ID_FORMAT = /\A[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}\z/

  def default_url_options
    options = { locale: I18n.locale }
    options[:app_id] = current_app_id if current_app_id
    options
  end

  private

  # Not memoized: url helpers can invoke this via default_url_options before
  # the request params are populated, and a cached nil would then outlive them.
  def current_app_id
    params[:app_id] if params[:app_id].to_s.match?(APP_ID_FORMAT)
  end

  def validate_app_id
    redirect_to(root_path) unless current_app_id
  end

  def set_locale
    I18n.locale = sanitized_locale
  end

  def sanitized_locale
    return params[:locale] if %w[en cy].include?(params[:locale])

    I18n.default_locale
  end

  def online_application
    @online_application ||= builder.online_application
  end

  def builder
    @builder ||= OnlineApplicationBuilder.new(storage)
  end

  def storage
    @storage ||= Storage.new(session, current_app_id)
  end

  def suppress_browser_cache
    response.headers['Cache-Control'] = 'private, no-store, max-age=0, must-revalidate'
    response.headers['Pragma'] = 'no-cache'
    response.headers['Expires'] = 'Fri, 01 Jan 1990 00:00:00 GMT'
  end

  def redirect_if_storage_unstarted
    redirect_to(root_path) unless storage.started?
  end

  def expired_redirect
    flash[:error] = t('session.expired_message')
    redirect_to(root_path)
  end

  def show_maintenance_page(config = Rails.application.config)
    return if !config.maintenance_enabled || config.maintenance_allowed_ips.include?(request.remote_ip)

    render 'static/maintenance', status: :ok
  end

end
