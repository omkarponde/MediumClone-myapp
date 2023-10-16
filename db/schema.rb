# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_08_13_061556) do
  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

# Could not dump table "followers" because of following StandardError
#   Unknown type '' for column 'id'

# Could not dump table "playlists" because of following StandardError
#   Unknown type 'uuid' for column 'id'

  create_table "playlists_posts", id: false, force: :cascade do |t|
    t.integer "playlist_id", null: false
    t.integer "post_id", null: false
    t.index ["playlist_id", "post_id"], name: "index_playlists_posts_on_playlist_id_and_post_id"
    t.index ["post_id", "playlist_id"], name: "index_playlists_posts_on_post_id_and_playlist_id"
  end

# Could not dump table "post_revisions" because of following StandardError
#   Unknown type 'uuid' for column 'id'

# Could not dump table "posts" because of following StandardError
#   Unknown type '' for column 'id'

# Could not dump table "profiles" because of following StandardError
#   Unknown type 'uuid' for column 'id'

# Could not dump table "saved_posts" because of following StandardError
#   Unknown type 'uuid' for column 'id'

# Could not dump table "users" because of following StandardError
#   Unknown type 'uuid' for column 'id'

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "followers", "users", column: "follower_id_id"
  add_foreign_key "followers", "users", column: "following_id_id"
  add_foreign_key "playlists", "users"
  add_foreign_key "posts", "users"
  add_foreign_key "profiles", "users"
  add_foreign_key "saved_posts", "posts"
  add_foreign_key "saved_posts", "users"
end
