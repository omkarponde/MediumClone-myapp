class CreateFollowers < ActiveRecord::Migration[7.0]
  def change
    create_table :followers, id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
      t.integer :follower_id
      t.integer :following_id
      t.timestamps
    end
  end
end
