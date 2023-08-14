class PlaylistsController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token
  def new
    @playlist = current_user.playlists.build
  end

  def create
    @playlist = current_user.playlists.build(playlist_params)
    if @playlist.save
      render json: current_user.playlists
    else
      render json: {"message": "Playlist not created"}
    end
  end

  def show
    @playlist = current_user.playlists.find(params[:playlist_id])
    @posts_in_playlist = @playlist.posts
    render json: @posts_in_playlist
  end

  def add_post
    @playlist = current_user.playlists.find(params[:playlist_id])
    @post = Post.find(params[:post_id])
    @playlist.posts << @post
    @posts_in_playlist = @playlist.posts
    render json: @posts_in_playlist, notice: 'Post added to playlist!'
  end

  def remove_post
    @playlist = current_user.playlists.find(params[:playlist_id])
    @post = Post.find(params[:post_id])
    @playlist.posts.delete(@post)
    @posts_in_playlist = @playlist.posts
    render json: @posts_in_playlist, notice: 'Removed to playlist!'
  end

  def share
    @playlist = current_user.playlists.find(params[:id])
    # Logic to generate a shareable link or send notifications to share the playlist
    redirect_to @playlist, notice: 'Playlist shared!'
  end

  private

  def playlist_params
    params.require(:playlist).permit(:name)
  end
end
