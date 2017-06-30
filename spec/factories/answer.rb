require 'faker'

FactoryGirl.define do
  factory :answer do
    text { Faker::HarryPotter.quote }
    user_id { User.all.sample.id }
    question_id { Question.all.sample.id }
  end
end
