class Users::NotificationsController < ApplicationController
  def index
    @notifications = current_user.notifications
    render json: @notifications, status: 200
  end
end
