# == Schema Information
#
# Table name: notifications
#
#  id              :integer          not null, primary key
#  actor_id        :integer
#  recipient_id    :integer
#  read_at         :datetime
#  notifiable_id   :integer
#  notifiable_type :string
#  pristine        :boolean          default(TRUE)
#  action_type     :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_notifications_on_recipient_id  (recipient_id)
#

class NotificationSerializer < ActiveModel::Serializer
  attributes :id, :actor, :action_type, :read_at, :notifiable_id, :notifiable_type, :photo_url, :meta_data

  def actor
    {
      id: object.actor.id,
      username: object.actor.username,
      avatar_url: object.actor.avatar_url(:thumb)
    }
  end

  def photo_url
    return object.notifiable.photo_url if object.notifiable_type == 'Post'
  end

  def meta_data
    case object.action_type
    when 'LIKE_POST'
      like_post_meta_data
    when 'START_FOLLOWING'
      start_following_meta_data
    when 'COMMENT_ON_POST'
      comment_on_post_meta_data
    end
  end

  private

  def like_post_meta_data
    { like_count: object.notifiable.reload.likes_count }
  end

  def start_following_meta_data
    { follower_ids: object.notifiable.follower_ids }
  end

  def comment_on_post_meta_data
    CommentSerializer.new(object.notifiable.comments.last)
  end
end
