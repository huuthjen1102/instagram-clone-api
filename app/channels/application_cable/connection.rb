module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    private

    def find_verified_user
      (verified_user = User.find_by(id: auth_token_payload[:user_id])).present? ? verified_user : reject_unauthorized_connection
    end

    def auth_token_payload
      begin
        @auth_token_payload ||= JsonWebToken.decode(request.params[:token])
      rescue JWT::VerificationError, JWT::DecodeError
        return OpenStruct.new(user_id: nil)
      end
    end
  end
end
