post '/questions/:question_id/answers' do
  answer = Answer.create(text: params[:text], question_id: params[:question_id], user_id: User.all.sample.id)
  if answer.valid?
    redirect "/questions/#{params[:question_id]}"
  else
    status 422
    @question = Question.find(params[:question_id])
    @answers = @question.answers
    @question_comments = @question.comments
    erb :'questions/show', locals: { errors: answer.errors.full_messages }
  end
end
