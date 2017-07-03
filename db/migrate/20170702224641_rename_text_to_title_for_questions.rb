class RenameTextToTitleForQuestions < ActiveRecord::Migration
  def change
    rename_column :questions, :text, :title
  end
end
