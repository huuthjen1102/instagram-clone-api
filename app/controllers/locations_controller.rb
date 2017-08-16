class LocationsController < ApplicationController
  # GET: /api/locations/api
  # params: {}
  def show
    @posts = Post.includes(:user, comments: [:user]).where(place_id: params[:id]).order(created_at: :desc)
    render json: @posts, status: 200
  end
end
