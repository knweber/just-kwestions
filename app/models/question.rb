class Question < ActiveRecord::Base
  validates :text, presence: true
  validates :user_id, presence: true

  belongs_to :user
  has_many :answers
  has_one :best_answer, class_name: "Answer"
  has_many :comments, as: :commentable
  has_many :votes, as: :voteable
end
