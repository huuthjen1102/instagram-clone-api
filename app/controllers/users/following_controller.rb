class Users::FollowingController < ApplicationController
  before_action :set_user, only: [:index]

  # GET: /api/users/:username/following
  # params: {}
  def index
    @following = @user.following
    render json: @following, status: 200
  end

  private

  def set_user
    @user = User.find_by(username: params[:username])
  end
end
