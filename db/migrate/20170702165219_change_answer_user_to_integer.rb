class ChangeAnswerUserToInteger < ActiveRecord::Migration
  def change
    change_column :answers, :user_id, 'integer USING CAST(user_id AS integer)'
  end
end
