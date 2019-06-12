class CreateRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :relationships do |t|
      t.bigint "user_id"
      t.bigint "follow_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["follow_id"], name: "index_relationships_on_follow_id"
      t.index ["user_id", "follow_id"], name: "index_relationships_on_user_id_and_follow_id", unique: true
      t.index ["user_id"], name: "index_relationships_on_user_id"
    end
  end
end
