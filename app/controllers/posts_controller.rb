
class PostsController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token



  def index
    @published_posts = Post.published
    render json: @published_posts
  end

  def published_posts
    @published_posts = Post.published
    render json: @published_posts
  end


  def show
    # @post = current_user.posts
    @published_posts = current_user.posts.published
    render json: @published_posts
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      render json: @post, status: :created
    else
      render :new
    end
  end

  # Action to update an existing post
  def update
    # Check if the current user owns the post
    @post = Post.find(params[:id])



    if @post.user == current_user

      unless @post.published?
        redirect_to @post, alert: 'You can only update published posts.'
        return
      end

      if @post.update(post_params)
        redirect_to @post, notice: 'Post was successfully updated.'
      else
        render :edit
      end
    else
      render json: {message: "You can edit only your posts"}
    end
  end


  # Action to delete a post
  def delete
    # Check if the current user owns the post
    @post = Post.find(params[:id])
    if @post.user == current_user
      unless @post.published?
        redirect_to @post, alert: 'You can only delete published posts.'
        return
      end
      @post.destroy
      render json: "post was deleted successfully"
    else
      redirect_to @post, alert: "You can only delete your own posts."
    end
  end

  #filters
  def filter_by_user
    filtered_posts = Post.published.where(user_id: desired_user_id)
    render json: filtered_posts
  end
  def filter_by_time_range
    start_time = params[:start_time]
    end_time = params[:end_time]

    @filtered_posts = Post.published.filter_by_time_range(start_time, end_time)
  end

  def search
    search_query = params[:query].downcase
    @articles = Post.where("LOWER(title) LIKE ? OR LOWER(topic) LIKE ? OR LOWER(author) LIKE ?", "%#{search_query}%", "%#{search_query}%", "%#{search_query}%")

    render json: @posts
end



  def recommended_posts
    # Assuming the user is authenticated and you have their ID
    user = User.find(@current_user.id)

    # Split the comma-separated string into an array of topics
    interested_topics = user.interested_topics.split(',')

    # Find recommended posts with matching topics
    recommended_posts = Post.where(topic: interested_topics)

    render json: recommended_posts
  end

  def top_posts
      # Retrieve the top posts based on the number of likes (adjust the criteria as needed)
      likes_weight = 0.7
      comments_weight = 0.3

      @top_posts = Post.all.map do |post|
        {
          post: post,
          score: (post.likes * likes_weight) + (post.comments * comments_weight)
        }
      end.sort_by { |data| -data[:score] }.first(10).map { |data| data[:post] }

      # Render the top posts as JSON
      render json: @top_posts
  end

  # actions for saved posts

  def save_post
    post = Post.find_by(id: params[:id])
    unless post.published?
      render json: {message: "You can ony save published posts"}
      return
    end

    current_user.saved_posts.create(post: post)
    render json: {message: "Post saved successfully"}
  end

  def unsave_post
    saved_post = current_user.saved_posts.find_by(post_id: params[:post_id])
    saved_post.destroy if saved_post
    render json: {message: "Post unsaved successfully"}
  end

  def saved_posts
    @saved_posts = current_user.saved_posts.includes(:post)
    render json: @saved_posts
  end


  # drafts
  def new_draft
    @post = current_user.posts.new(status: "draft")
  end

  def my_drafts
    @draft_posts = current_user.posts.draft
    render json: @draft_posts
  end


  def create_draft
    @post = current_user.posts.new(post_params.merge(status: "draft"))


    if @post.save
      redirect_to @post, notice: 'Draft created successfully'
    else
      render :new_draft
    end
  end

  def edit_draft
    @post = current_user.posts.draft.find(params[:id])
  end

  def update_draft
    @post = current_user.posts.draft.find(params[:id])
    if @post.user == current_user
      if @post.update(post_params)
        redirect_to @post, notice: 'Draft updated successfully'
      else
        render :edit_draft
      end
    else
      render json: {message: "You can edit only your draft"}
    end

  end

  def delete_draft
    # Check if the current user owns the post
    @post = current_user.posts.draft.find(params[:id])
    if @post.user == current_user
      @post.destroy
      render json: "post was deleted successfully"
    else
      render json: {message: "You can delete only your draft"}
    end
  end

  def publish
    @post = current_user.posts.draft.find(params[:id])

    if @post.user == current_user
      @post.update(status: "published")
      redirect_to @post, notice: 'Post published successfully'
    else
      render json: {message: "You can publish only your draft"}
    end
  end

  # rerieving the revision histry of the current user
  def revision_history
    @post_revisions = current_user.post_revisions
    render json: @post_revisions
  end





  private

  # Set the current post based on the ID parameter
  def set_post
    @post = Post.find(params[:id])
  end



  # Define the allowed parameters for creating and updating posts
  def post_params
    params.require(:post).permit(:title, :topic, :description, :likes, :comments, :views, :image)
  end
  def post_json
    {
      id: @post.id,
      title: @post.title,
      topic: @post.topic,
      description: @post.description,
      likes: @post.likes,
      comments: @post.comments,
      views: @post.views,
      user_id: @post.user_id
    }
  end
end
