require 'faker'

FactoryGirl.define do
  factory :user do
    username { Faker::Internet.user_name(5..8) }
    email { Faker::Internet.safe_email }
    password '12345678'
  end

end
