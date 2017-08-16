class Posts::CommentsController < ApplicationController
  before_action :set_post, only: [:create]

  # POST: /api/posts/:post_id/comments
  # params: { body: text }
  def create
    @comment = @post.comments.build(comment_params.merge(user_id: current_user.id))

    if @comment.save
      render json: @comment, status: 201
    else
      render json: { errors: @comment.errors.full_messages }, status: 422
    end
  end

  private

  def comment_params
    params.permit(:body)
  end

  def set_post
    @post = Post.find(params[:post_id])
  end
end
