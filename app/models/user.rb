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

class User < ApplicationRecord
  has_secure_password

  # associations
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post

  # validations
  validates :email, presence: true,
                    uniqueness: { case_sensitive: false },
                    format: { with: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i }
  validates :username, presence: true,
                       uniqueness: { case_sensitive: false }

  # uploaders
  mount_uploader :avatar, AvatarUploader

  def like!(post)
    likes.where(post_id: post.id).first_or_create!
  end

  def dislike!(post)
    likes.where(post_id: post.id).destroy_all
  end
end
