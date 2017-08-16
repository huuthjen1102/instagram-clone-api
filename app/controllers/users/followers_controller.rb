class Users::FollowersController < ApplicationController
  before_action :set_user, only: [:index]

  # GET: /api/users/:username/followers
  # params: {}
  def index
    @followers = @user.followers
    render json: @followers, status: 200
  end

  private

  def set_user
    @user = User.find_by(username: params[:username])
  end
end
