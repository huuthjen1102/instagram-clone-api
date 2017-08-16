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
