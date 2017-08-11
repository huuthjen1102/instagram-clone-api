class AvatarImagesController < ApplicationController
  # PATCH: api/me/upload
  # params: { avatar: image }
  def update
    binding.pry
    if current_user.update(avatar: params[:avatar])
      render json: { url: current_user.avatar.url(:thumb) }, status: 200
    else
    render json: { errors: ['Oops something went wrong. Please try again'] }, status: 422
    end
  end
end
