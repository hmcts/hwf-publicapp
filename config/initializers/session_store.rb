# Be sure to restart your server when you modify this file.

Rails.application.config.session_store :cookie_store,
                                       key: '_hwf-publicapp_session',
                                       same_site: :strict,
                                       secure: Rails.env.production?,
                                       domain: ->(request) { determine_domain(request.host) }

def determine_domain(host)
  valid_domains = Settings.session_store.valid_domains || []

  valid_domains.each do |domain|
    return domain if host.end_with?(domain)
  end

  nil
end
