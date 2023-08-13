class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise :database_authenticatable, :registerable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

   has_one :profile
   has_many :posts
   has_many :post_revisions, through: :posts

   has_many :follower_relationships, class_name: 'Follower', foreign_key: 'follower_id'
   has_many :following_relationships, class_name: 'Follower', foreign_key: 'following_id'

   has_many :followers, through: :following_relationships, source: :follower_user
   has_many :following, through: :follower_relationships, source: :following_user

    # has_many :save_for_laters
    # has_many :saved_posts, through: :save_for_laters, source: :post
    has_many :saved_posts
    has_many :playlists

   def follow(other_user)
      following << other_user
    end

    def unfollow(other_user)
      following.delete(other_user)
    end

    def following?(other_user)
      following.include?(other_user)
    end




  def revision_history
    post_revisions.order(created_at: :desc)
  end
end
