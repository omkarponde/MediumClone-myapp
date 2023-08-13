class Playlist < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :posts, join_table: :playlists_posts
end
