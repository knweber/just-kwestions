class AddTextToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :text, :text
    change_column_null :questions, :text, false, "placeholder"
    change_column_default :questions, :text, nil
  end
end
