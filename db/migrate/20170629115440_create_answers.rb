class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.string  :answer, null:false
      t.integer :question_id, null:false
      t.string  :user_id, null:false

      t.timestamps
  end
end
