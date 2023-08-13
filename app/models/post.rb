class Post < ApplicationRecord
  has_one_attached :image
  belongs_to :user

  # has_many :save_for_laters
  # has_many :users_who_saved, through: :save_for_laters, source: :user
  has_many :saved_posts

  enum status: { draft: "draft", published: "published" }, _default: "published"


  has_many :post_revisions

  after_update :create_revision

  private

  def create_revision
    post_revisions.create(
      title: title_was,
      topic: topic_was,
      description: description_was,
      likes: likes_was,
      comments: comments_was,
      views: views_was,
      user_id: user_id_was,
      status: status_was
    )
  end
end
