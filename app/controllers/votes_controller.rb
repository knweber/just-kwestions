post '/questions/:question_id/votes' do
  question = Question.find(params[:question_id])
  question.votes.create(user_id: User.all.sample.id)
  redirect "/questions/#{question.id}"
end

delete '/questions/:question_id/votes/ham' do
  question = Question.find(params[:question_id])
    question.votes.delete(Vote.find_by(voteable_id: question.id, voteable_type: "Question"))
    redirect "/questions/#{question.id}"
end
