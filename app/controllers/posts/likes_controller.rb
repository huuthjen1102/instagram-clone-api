class Posts::LikesController < ApplicationController
  before_action :set_post

  # POST: /api/posts/:post_id/likes
  # params: {}
  def create
    current_user.like!(@post)
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
