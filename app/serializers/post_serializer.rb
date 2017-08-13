class PostSerializer < ActiveModel::Serializer
  attributes :id, :photo_url, :caption, :filter, :created_at, :user_id
  belongs_to :user, serializer: SimpleUserSerializer

  def photo_url
    object.photo.url
  end
end
