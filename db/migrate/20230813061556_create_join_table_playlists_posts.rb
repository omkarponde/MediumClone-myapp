class CreateJoinTablePlaylistsPosts < ActiveRecord::Migration[7.0]
  def change
    create_join_table :playlists, :posts do |t|

      t.index [:playlist_id, :post_id]
      t.index [:post_id, :playlist_id]
    end
  end
end
