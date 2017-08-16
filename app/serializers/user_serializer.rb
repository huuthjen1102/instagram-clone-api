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
#
# Indexes
#
#  index_users_on_username  (username) UNIQUE
#

class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :avatar_url

  def avatar_url
    object.avatar.url(:thumb)
  end
end
