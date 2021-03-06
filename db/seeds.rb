require 'faker'

User.destroy_all
Question.destroy_all
Answer.destroy_all
Comment.destroy_all
Vote.destroy_all

10.times do
  User.create(username: Faker::Internet.user_name(5..8), email: Faker::Internet.safe_email, password: 'kwestions')
end

15.times do
  Question.create(title: Faker::StarWars.quote, text: Faker::StarWars.wookie_sentence, user_id: User.all.sample.id)
end

50.times do
  Answer.create(text: Faker::HarryPotter.quote, user_id: User.all.sample.id, question_id: Question.all.sample.id)
end

100.times do
  Comment.create(text: Faker::Hipster.sentence, user_id: User.all.sample.id, commentable_id: Question.all.sample.id, commentable_type: "Question")

  Comment.create(text: Faker::Hipster.sentence, user_id: User.all.sample.id, commentable_id: Answer.all.sample.id, commentable_type: "Answer")
end

User.all.each do |user|
  Question.all.each do |question|
    question.votes.create(user_id: user.id, upvote: rand(2) == 0)
  end
  Answer.all.each do |answer|
    answer.votes.create(user_id: user.id, upvote: rand(2) == 0)
  end
  Comment.all.each do |comment|
    comment.votes.create(user_id: user.id, upvote: rand(2) == 0)
  end
end
