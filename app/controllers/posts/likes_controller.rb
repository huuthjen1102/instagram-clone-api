class Posts::LikesController < ApplicationController
  before_action :set_post

  # POST: /api/posts/:post_id/likes
  # params: {}
  def create
    current_user.like!(@post)
    unless @post.user.id == current_user.id
      Notification.create(actor: current_user, recipient: @post.user,
                          notifiable: @post, action_type: 'LIKE_POST')
    end
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
end
