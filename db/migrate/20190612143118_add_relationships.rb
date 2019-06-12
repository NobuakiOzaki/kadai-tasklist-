class AddRelationships < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key "relationships", "users"
    add_foreign_key "relationships", "users", column: "follow_id"
  end
end
