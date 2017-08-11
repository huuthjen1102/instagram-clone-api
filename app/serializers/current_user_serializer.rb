class CurrentUserSerializer < ActiveModel::Serializer
  attributes :id, :email, :username, :created_at, :authentication_token, :avatar_url

  def authentication_token
    JsonWebToken.encode({ user_id: object.id, email: object.email })
  end

  def avatar_url
    object.avatar.url(:thumb)
  end
end
