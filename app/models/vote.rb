class Vote < ActiveRecord::Base
  belongs_to :voteable, polymorphic: true
  belongs_to :user

  validates_uniqueness_of :user_id, :scope => [:voteable_type, :voteable_id]
end
