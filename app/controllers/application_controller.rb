class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods

  attr_reader :current_user
  before_action :authenticate_user!

  def authenticate_user!
    authenticate_user_from_token || render_unauthorized
  end

  def pagination_dict(resources)
    {
      current_page: resources.current_page,
      prev_page: resources.previous_page,
      next_page: resources.next_page,
      total_pages: resources.total_pages,
      total_count: resources.total_entries
    }
  end

  protected

  def authenticate_user_from_token
    return unless user_id_in_token?
    @current_user ||= User.find_by(id: auth_token[:user_id])
  end

  def render_unauthorized
    self.headers['WWW-Authenticate'] = "Token realm='Application'"
    render json: { errors: ['Bad credentials'] }, status: 401
  end

  def user_id_in_token?
    http_token && auth_token && auth_token[:user_id]
  end

  def http_token
    authenticate_with_http_token do |token, options|
      return token
    end
  end

  def auth_token
    JsonWebToken.decode(http_token)
  rescue JWT::VerificationError, JWT::DecodeError
    nil
  end
end
