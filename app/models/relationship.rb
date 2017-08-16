# == Schema Information
#
# Table name: relationships
#
#  id          :integer          not null, primary key
#  follower_id :integer
#  followed_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_relationships_on_followed_id  (followed_id)
#  index_relationships_on_follower_id  (follower_id)
#

class Relationship < ApplicationRecord
  # assocications
  belongs_to :follower, class_name: 'User'
  belongs_to :followed, class_name: 'User'

  # validations
  validates :follower, presence: true
  validates :followed, presence: true
end
