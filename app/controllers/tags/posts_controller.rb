class Tags::PostsController < ApplicationController
  before_action :set_tag, only: [:index]

  def index
    if @tag.present?
      @posts = @tag.posts.includes(:user, comments: [:user])
                   .order(created_at: :desc)
                   .paginate(page: params[:page], per_page: 20)
      render json: @posts, meta: pagination_dict(@posts), status: 200
    else
      render json: { errors: ["Tag #{params[:tag_name]} not found"] }, status:422
    end
  end

  private

  def set_tag
    @tag = Tag.find_by(name: params[:tag_name])
  end
end
