class PlaylistsController < ApplicationController
  before_action :authenticate_user! # Assuming you're using Devise or a similar authentication gem

  def new
    @playlist = current_user.playlists.build
  end

  def create
    @playlist = current_user.playlists.build(playlist_params)
    if @playlist.save
      redirect_to @playlist, notice: 'Playlist created successfully!'
    else
      render :new
    end
  end

  def show
    @playlist = current_user.playlists.find(params[:id])
  end

  def add_post
    @playlist = current_user.playlists.find(params[:playlist_id])
    @post = Post.find(params[:post_id])
    @playlist.posts << @post
    redirect_to @playlist, notice: 'Post added to playlist!'
  end

  def remove_post
    @playlist = current_user.playlists.find(params[:playlist_id])
    @post = Post.find(params[:post_id])
    @playlist.posts.delete(@post)
    redirect_to @playlist, notice: 'Post removed from playlist!'
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
