# == Schema Information
#
# Table name: posts
#
#  id             :integer          not null, primary key
#  caption        :text
#  photo          :string
#  user_id        :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  filter         :string
#  address        :string
#  lat            :float
#  lng            :float
#  likes_count    :integer          default(0)
#  comments_count :integer          default(0)
#
# Indexes
#
#  index_posts_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

class PostSerializer < ActiveModel::Serializer
  attributes :id, :photo_url, :caption, :filter, :created_at, :user_id, :lat_lng, :address, :likes_count, :comments_count
  belongs_to :user, serializer: SimpleUserSerializer

  def photo_url
    object.photo.url
  end

  def lat_lng
    { lat: object.lat, lng: object.lng }
  end
end
