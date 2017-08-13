class CurrentUserSerializer < ActiveModel::Serializer
  attributes :id, :created_at, :authentication_token, :post_ids, :attrs

  def authentication_token
    JsonWebToken.encode({ user_id: object.id, email: object.email })
  end

  def attrs
    {
      email: object.email,
      username: object.username,
      avatar_url: object.avatar.url(:thumb)
    }
  end
end
