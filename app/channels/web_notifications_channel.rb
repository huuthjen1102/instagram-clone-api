class WebNotificationsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "web_notifcations_#{current_user.id}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
