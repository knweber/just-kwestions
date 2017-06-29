class Question < ActiveRecord::Base
  validates :text, presence: true
  validates :user_id, presence: true

  belongs_to :user
  has_many :answers
  has_many :comments, as: :commentable
end
