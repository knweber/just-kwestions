class Question < ActiveRecord::Base
  belongs_to :user
  validates :prompt, presence: true
  validates :user_id, presence: true
end
