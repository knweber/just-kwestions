class Question < ActiveRecord::Base
  has_many :answers
  has_many :comments, as: :commentable
end
