class SimplePostSerializer < ActiveModel::Serializer
  attributes :id, :photo_url, :likes_count, :comments_count
end
