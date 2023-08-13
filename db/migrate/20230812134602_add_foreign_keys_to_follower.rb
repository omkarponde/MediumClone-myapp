class AddForeignKeysToFollower < ActiveRecord::Migration[7.0]
  def change
    add_reference :followers, :follower_id, foreign_key: { to_table: :users }
    add_reference :followers, :following_id, foreign_key: { to_table: :users }
  end
end
