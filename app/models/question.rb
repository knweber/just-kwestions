class Question < ActiveRecord::Base
  validates :prompt, presence: true
end
