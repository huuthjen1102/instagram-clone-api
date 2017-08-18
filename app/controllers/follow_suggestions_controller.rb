class FollowSuggestionsController < ApplicationController
  # GET: /api/follow_suggestions
  # params: {}
  def index
    # TODO: find suggestions using graph search
    @users = User.includes(:recent_posts).order(created_at: :desc).limit(10) - [current_user]
    render json: @users, each_serializer: FollowSuggestionSerializer, status: 200
  end
end
