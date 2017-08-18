class Users::NotificationCountsController < ApplicationController
  # GET: /api/users/notification_counts
  # params: {}
  def show
    @notification_count = current_user.notifications.pristine.count
    render json: { count: @notification_count }, status: 200
  end

  # DELETE: /api/users/notification_counts
  # params: {}
  def destroy
    current_user.notifications.update_all(pristine: false)
    head 204
  end
end
