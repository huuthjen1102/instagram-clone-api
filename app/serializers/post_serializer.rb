class PostSerializer < ActiveModel::Serializer
  attributes :id, :photo_url, :caption, :filter, :created_at, :user_id, :lat_lng, :address
  belongs_to :user, serializer: SimpleUserSerializer

  def photo_url
    object.photo.url
  end

  def lat_lng
    { lat: object.lat, lng: object.lng }
  end
end
