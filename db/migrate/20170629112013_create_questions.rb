class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :text, null:false
      t.integer :user_id, null:false
      t.timestamps
    end
  end
end
