class PostsController < ApplicationController
  # GET: /api/posts
  # params: {}
  def index
    @posts = Post.includes(:user, comments: [:user]).all.order(created_at: :desc)
    render json: @posts, status: 200
  end

  # POST: /api/posts
  # params: { caption: string, photo: image }
  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      render json: @post, status: 201
    else
      render json: { errors: @post.errors.full_messages }, status: 422
    end
  end

  private

  def post_params
    params.permit(:caption, :photo, :filter, :address, :lat, :lng, :place_id)
  end
end
