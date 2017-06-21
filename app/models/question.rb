class Question < ActiveRecord::Base
  validates :prompt, presence: true
  has_many :responses
end
