get '/questions/:id' do
  @question = Question.find(params[:id])
  @answers = @question.answers
  @question_comments = @question.comments
  erb :'questions/show'
end
