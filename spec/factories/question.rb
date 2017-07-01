require 'faker'

FactoryGirl.define do
  factory :question do
    text { Faker::StarWars.quote }
    user_id { User.all.sample.id }
  end
end
