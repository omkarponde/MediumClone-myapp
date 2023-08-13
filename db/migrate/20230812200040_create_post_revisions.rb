class CreatePostRevisions < ActiveRecord::Migration[7.0]
  def change
    create_table :post_revisions do |t|
      t.integer :post_id
      t.string :title
      t.string :topic
      t.text :description
      t.integer :likes
      t.integer :comments
      t.integer :views
      t.integer :user_id
      t.string :status

      t.timestamps
    end
  end
end
