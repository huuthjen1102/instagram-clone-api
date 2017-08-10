class PostsController < ApplicationController
  def index
    render json: { posts: ['post1', 'post2'] }, status: 200
  end
end
