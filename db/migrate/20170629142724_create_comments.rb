class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :text, null: false
      t.integer :user_id, null: false
      t.integer :commentable_id
      t.string :commentable_type
      t.timestamps
    end
  end
end
