class Users::PostsController < ApplicationController
  before_action :set_user, only: [:index]

  # GET: /api/users/:username/posts
  # params: {}
  def index
    if @user.present?
      @posts = @user.posts.order(created_at: :desc)
                          .paginate(page: params[:page], per_page: 9)
      render json: @posts, each_serializer: SimplePostSerializer, status: 200
    else
      render json: { errors: ['User not found'] }, status: 404
    end
  end

  private

  def set_user
    @user = User.find_by(username: params[:username])
  end
end
