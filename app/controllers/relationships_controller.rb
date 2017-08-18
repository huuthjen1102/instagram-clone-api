class RelationshipsController < ApplicationController
  before_action :set_target_user

  # POST: /api/follow/:user_id
  # params: {}
  def create
    if current_user.follow(@target_user)
      create_notification('START_FOLLOWING')
      render json: @target_user, status: 200
    else
      render json: { errors: ['Could not follow user'] }, status: 422
    end
  end

  # DELETE: /api/unfollow/:user_id
  # params: {}
  def destroy
    if current_user.unfollow(@target_user)
      render json: @target_user, status: 200
    else
      render json: { errors: ['Could not unfollow user'] }, status: 422
    end
  end

  private

  def set_target_user
    @target_user = User.find_by(id: params[:user_id])
    render json: { errors: ['User not found'] }, status: 422 and return unless @target_user.present?
  end

  def create_notification(action_type)
    notification = Notification.create(actor: current_user, recipient: @target_user, notifiable: @target_user, action_type: action_type)

    ActionCable.server.broadcast(
      "web_notifcations_#{@target_user.id}",
      json: NotificationSerializer.new(notification).to_json
    )
  end
end
