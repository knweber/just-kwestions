class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.string :content
      t.boolean :correct_answer
      t.belongs_to :question
      t.timestamps
    end
  end
end
