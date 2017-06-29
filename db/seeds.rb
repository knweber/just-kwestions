require 'faker'

User.destroy_all
Question.destroy_all
Answer.destroy_all

10.times do
  User.create(username: Faker::Internet.user_name(5..8))
end

15.times do
  Question.create(prompt: Faker::StarWars.quote, user_id: User.all.sample.id)
end

50.times do
  Answer.create(answer: Faker::HarryPotter.quote, user_id: User.all.sample.id, question_id: Question.all.sample.id)
end
