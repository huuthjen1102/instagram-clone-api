class Users::PublicProfilesController < ApplicationController
  before_action :set_user, only: [:show]

  # GET: /api/users/:username/public_profile
  # params: {}
  def show
    if @user.present?
      render json: @user, serializer: PublicProfileSerializer, status: 200
    else
      render json: { errors: ['User not found'] }, status: 404
    end
  end

  private

  def set_user
    @user = User.find_by(username: params[:username])
  end
end
