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
#  place_id       :integer
#  filter_style   :json
#
# Indexes
#
#  index_posts_on_place_id  (place_id)
#  index_posts_on_user_id   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

class PostSerializer < ActiveModel::Serializer
  attributes :id, :photo_url, :caption, :filter, :created_at, :user_id, :lat_lng, :address,
             :place_id, :likes_count, :comments_count, :filter_style, :comment_pagination

  belongs_to :user
  has_many :comments

  def lat_lng
    { lat: object.lat, lng: object.lng }
  end

  def comments
    object.comments.latest.paginate(page: 1)
  end

  def comment_pagination
    {
      current_page: object.comments.current_page,
      prev_page: object.comments.previous_page,
      next_page: object.comments.next_page,
      total_pages: object.comments.total_pages,
      total_count: object.comments.total_entries
    }
  end
end
