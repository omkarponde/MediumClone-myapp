class CreateProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :profiles do |t|
      t.string :firstname
      t.string :lastname
      t.text :bio
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
