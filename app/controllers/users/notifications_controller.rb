class Users::NotificationsController < ApplicationController
  def index
    @notifications = current_user.notifications.includes(:actor, :notifiable)
                                 .order(created_at: :desc).paginate(page: params[:page], per_page: 20)
    render json: @notifications, meta: pagination_dict(@notifications), status: 200
  end

  def update
    @notification = current_user.notifications.find(params[:id])
    @notification.update(read_at: Time.current)
    head 204
end
