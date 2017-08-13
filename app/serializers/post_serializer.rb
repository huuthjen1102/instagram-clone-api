# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  caption    :text
#  photo      :string
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  filter     :string
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
  attributes :id, :photo_url, :caption, :filter, :created_at, :user_id

  def photo_url
    object.photo.url
  end
end
