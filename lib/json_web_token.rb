class JsonWebToken
  def self.encode(payload)
    JWT.encode(payload, secrets)
  end

  def self.decode(token)
    ActiveSupport::HashWithIndifferentAccess.new(JWT.decode(token, secrets).first)
  end

  private

  def self.secrets
    Rails.application.secrets.secret_key_base
  end
end
