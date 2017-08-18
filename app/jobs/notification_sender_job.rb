class NotificationSenderJob < ApplicationJob
  queue_as :default

  def perform(notification)
    ActionCable.server.broadcast "web_notifcations_#{notification.recipient.id}",
      NotificationSerializer.new(notification)
  end
end
