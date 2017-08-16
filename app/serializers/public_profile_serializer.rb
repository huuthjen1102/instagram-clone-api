class PublicProfileSerializer < ActiveModel::Serializer
  attributes :id, :created_at, :avatar_url, :username, :following_count, :followers_count

  def avatar_url
    object.avatar_url(:thumb)
  end

  def following_count
    object.following.count
  end

  def followers_count
    object.followers.count
  end
end
