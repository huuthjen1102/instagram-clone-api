class WebNotificationsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "web_notifcations_#{params[:username]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
