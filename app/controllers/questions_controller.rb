get '/questions' do
  @questions = Question.order(created_at: :asc)
  erb :'/questions/index'
end

get '/questions/:id' do
  "You clicked question #{params[:id]}"
end
