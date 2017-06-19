require 'faker'

100.times do
  Question.create(prompt: Faker::Lorem.sentence)
end
