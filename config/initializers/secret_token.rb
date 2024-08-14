class SecretToken
  def self.generate
    Rails.env.production? ? ENV.fetch('SECRET_TOKEN', nil) : ('a' * 30)
  end
end
HwfPublicapp::Application.config.secret_key_base = SecretToken.generate