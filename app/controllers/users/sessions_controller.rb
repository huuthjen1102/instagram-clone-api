class Users::SessionsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:create]

  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      render json: user, serializer: CurrentUserSerializer, status: 201
    else
      render json: { errors: ['Invalid email or password'] }, status: 422
    end
  end
end
