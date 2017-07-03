require 'faker'

FactoryGirl.define do
  factory :question do
    title { Faker::StarWars.quote }
    text { Faker::StarWars.wookie_sentence }
    user_id { User.all.sample.id }
  end
end
