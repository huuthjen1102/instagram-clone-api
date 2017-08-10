class Users::SessionsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:create]

  def create
    find_condition = params[:email].present? ? { email: params[:email] } : { username: params[:username] }
    user =  User.find_by(find_condition)

    if user && user.authenticate(params[:password])
      render json: user, serializer: CurrentUserSerializer, status: 201
    else
      render json: { errors: ['Invalid email or password'] }, status: 422
    end
  end
end
