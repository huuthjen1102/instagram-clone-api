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
  attributes :id, :actor, :action_type, :read_at, :notifiable_id, :notifiable_type, :photo_url

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
end
