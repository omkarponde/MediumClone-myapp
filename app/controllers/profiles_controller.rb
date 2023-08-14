
class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_profile, only: [:show, :update]
  skip_before_action :verify_authenticity_token

  # POST /profile
  def create
    @profile = current_user.build_profile(profile_params)

    if @profile.save
      render json: @profile, status: :created
    else
      render json: @profile.errors, status: :unprocessable_entity
    end
  end

  # GET /profile
  def show
    render json: profile_json
  end

  # PUT /profile
  def update
    if @profile.update(profile_params)
      render json: profile_json
    else
      render json: @profile.errors, status: :unprocessable_entity
    end
  end

  # GET /profiles
  def index
    @profiles = Profile.where.not(user_id: current_user.id) # Fetch profiles of other users
    render json: @profiles
  end

  # GET /profiles/:id
  # def show
  #   @profile = Profile.find(params[:id])
  #   render json: @profile
  # end



  private

  def set_profile
    @profile = current_user.profile
  end

  def profile_params
    params.require(:profile).permit(:firstname,:lastname, :bio, :interested_topics)
  end

  def profile_json
    {
      id: @profile.id,
      name: @profile.firstname,
      surname: @profile.lastname,
      bio: @profile.bio,
      interested_topics: @profile.interested_topics
    }
  end
end
