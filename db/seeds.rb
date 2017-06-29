require 'faker'

10.times do
  User.create(username: Faker::Internet.user_name(5..8))
end

15.times do
  Question.create(prompt: Faker::StarWars.quote, user_id: User.all.sample.id)
end
