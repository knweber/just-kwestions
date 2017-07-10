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
  @question = answer.question

  if answer.valid?
    if request.xhr?
      erb :"answers/_answer", layout: false, locals: { answer: answer }
    else
      redirect "/questions/#{params[:question_id]}"
    end
  else
    status 422
    if request.xhr?
      erb :'_errors', layout: false, locals: { errors: answer.errors.full_messages }
    else
      erb :'answers/new', locals: { errors: answer.errors.full_messages }
    end
  end
end

# put '/questions/:id' do
#   @question = Question.find(params[:question_id])
#   answer = Answer.find(params[:id])
#
#   erb :'answers/_answer', locals: { answer: answer }
# end
