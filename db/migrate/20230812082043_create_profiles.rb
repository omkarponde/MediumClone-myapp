class CreateProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :profiles, id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
      t.string :firstname
      t.string :lastname
      t.text :bio
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
