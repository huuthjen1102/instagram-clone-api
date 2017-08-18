class Posts::CommentsController < ApplicationController
  before_action :set_post

  # GET: /api/posts/:post_id/comments
  # params: {}
  def index
    @comments = @post.comments.includes(:user).latest.paginate(page: params[:page])
    render json: @comments, meta: pagination_dict(@comments), status: 200
  end

  # POST: /api/posts/:post_id/comments
  # params: { body: text }
  def create
    @comment = @post.comments.build(comment_params.merge(user_id: current_user.id))

    if @comment.save
      create_notification('COMMENT_ON_POST')
      render json: @comment, status: 201
    else
      render json: { errors: @comment.errors.full_messages }, status: 422
    end
  end

  # DELETE: /api/posts/:post_id/comments/:id
  # params: {}
  def destroy
    @comment = @post.comments.find(params[:id])
    unless @comment.user == current_user
      render json: { errors: ['Permission denied'] }, status: 422
    end
    @comment.destroy
    head 204
  end

  private

  def comment_params
    params.permit(:body)
  end

  def set_post
    @post = Post.find(params[:post_id])
  end

  def create_notification(action_type)
    unless @post.user.id == current_user.id
      notification = Notification.create(actor: current_user, recipient: @post.user,
                                         notifiable: @post, action_type: action_type)
      ActionCable.server.broadcast(
        "web_notifcations_#{@post.user.id}",
        NotificationSerializer.new(notification)
      )
    end
  end
end
