get '/questions' do
  @questions = Question.order(created_at: :asc)
  erb :'/questions/index'
end

get '/questions/:id' do
  @question = Question.find(params[:id])
  @answers = @question.answers
  erb :'questions/show'
end
