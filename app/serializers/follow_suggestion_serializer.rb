class FollowSuggestionSerializer < ActiveModel::Serializer
  attributes :id, :username, :avatar_url

  has_many :recent_posts, serializer: SimplePostSerializer

  def avatar_url
    object.avatar_url(:thumb)
  end
end
