class CreatePlaylists < ActiveRecord::Migration[7.0]
  def change
    create_table :playlists, id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
      t.string :name
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
