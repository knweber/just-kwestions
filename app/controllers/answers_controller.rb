get '/questions/:question_id/answers/new' do
  if session[:user_id]
    @question = Question.find(params[:question_id])
    erb :'answers/new'
  else
    redirect "/questions/#{params[:question_id]}"
  end
end

post '/questions/:question_id/answers' do
  if !session[:user_id]
    redirect "/questions/#{params[:question_id]}"
  end
  answer_params = params[:answer]
  answer_params[:user_id] = session[:user_id]
  answer = Answer.create(answer_params)
  if answer.valid?
    redirect "/questions/#{params[:question_id]}"
  else
    status 422
    @question = Question.find(params[:question_id])
    erb :'answers/new', locals: { errors: answer.errors.full_messages }
  end
end

put '/questions/:question_id/answers/:id' do
  @question = Question.find(params[:question_id])
  answer = Answer.find(params[:id])
  if request.xhr?
    erb :'answers/_answer', locals: { answer: answer }
  end
end
