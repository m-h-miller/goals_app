class CreateUserComments < ActiveRecord::Migration
  def change
    create_table :user_comments do |t|
      t.text :body, null: false
      t.integer :user_id, null: false
      t.integer :commenter_id, null: false

      t.timestamps null: false
    end

    add_index :user_comments, :user_id
    add_index :user_comments, :commenter_id
  end
end
