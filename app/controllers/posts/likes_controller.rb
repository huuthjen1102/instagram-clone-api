class Posts::LikesController < ApplicationController
  before_action :set_post

  # POST: /api/posts/:post_id/likes
  # params: {}
  def create
    current_user.like!(@post)
    create_notification('LIKE_POST')
    head 204
  end

  # DELETE: /api/posts/:post_id/likes
  # params: {}
  def destroy
    current_user.dislike!(@post)
    head 204
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def create_notification(action_type)
    unless @post.user.id == current_user.id
      notification = Notification.create(actor: current_user, recipient: @post.user, notifiable: @post, action_type: action_type)
      ActionCable.server.broadcast(
        "web_notifcations_#{@post.user.username}",
        json: NotificationSerializer.new(notification).to_json
      )
    end
  end
end
