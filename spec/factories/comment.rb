require 'faker'

FactoryGirl.define do
  factory :comment do
    text { Faker::Hipster.sentence }
    user_id { User.all.sample.id }
  end
end
