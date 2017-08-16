# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string
#  email           :string
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  avatar          :string
#  facebook_id     :string
#
# Indexes
#
#  index_users_on_facebook_id  (facebook_id)
#  index_users_on_username     (username) UNIQUE
#

class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :avatar_url

  def avatar_url
    object.avatar.url(:thumb)
  end
end
