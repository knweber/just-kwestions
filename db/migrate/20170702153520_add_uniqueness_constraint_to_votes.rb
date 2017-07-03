class AddUniquenessConstraintToVotes < ActiveRecord::Migration
  def change
    add_index :votes, [:user_id, :voteable_id, :voteable_type], unique: true
  end
end
