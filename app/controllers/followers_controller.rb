class FollowersController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token

  def follow
    @user= User.find(params[:id])
    current_user.follow(@user)
    render json: {message: "Following user"}
  end
  def unfollow
    @user= User.find(params[:id])
    current_user.unfollow(@user)
    render json: {message: "Unfollowed user"}
  end


end
