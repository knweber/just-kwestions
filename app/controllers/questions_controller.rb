get '/questions' do
  @questions = Question.order(created_at: :asc)
  erb :'/questions/index'
end
