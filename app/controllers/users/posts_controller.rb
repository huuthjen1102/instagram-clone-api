class Users::PostsController < ApplicationController
  before_action :set_user, only: [:index]

  # GET: /api/users/:username/posts
  # params: {}
  def index
    if @user.present?
      render json: @user.posts, each_serializer: SimplePostSerializer, status: 200
    else
      render json: { errors: ['User not found'] }, status: 404
    end
  end

  private

  def set_user
    @user = User.find_by(username: params[:username])
  end
end
