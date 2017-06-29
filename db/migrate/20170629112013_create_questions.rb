class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :prompt, null:false
      t.integer :user_id, null:false
      t.timestamps
    end
  end
end
