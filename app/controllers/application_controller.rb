class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :show_maintenance_page

  rescue_from Storage::Expired, with: :expired_redirect

  before_action :set_locale

  def default_url_options
    { locale: I18n.locale }
  end

  private

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
    @storage ||= Storage.new(session)
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
