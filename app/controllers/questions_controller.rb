get '/questions' do
  @questions = Question.order(created_at: :asc)
  erb :'questions/index'
end

get '/questions/new' do
  if session[:user_id] != nil
    erb :'questions/new', layout: !request.xhr?
  else
    redirect '/questions'
  end
end

get '/questions/:id' do
  @question = Question.find(params[:id])
  @answers = @question.answers
  @question_comments = @question.comments
  erb :'questions/show'
end

post '/questions' do
  if session[:user_id] != nil
    question_params = params[:question]
    question_params[:user_id] = session[:user_id]
    question = Question.new(question_params)
    if request.xhr?
      if question.valid?
        question.save!
        erb :'questions/_question', layout: false, locals: { question: question }
      else
        status 422
        erb :'questions/new', locals: { errors: question.errors.full_messages }
      end
    else
      redirect '/'
    end
  end
end

put '/questions/:id' do
  question = Question.find(params[:id])
  if session[:user_id] == question.user_id
    question.best_answer = Answer.find(params[:answer_id])
    question.save # curse you activerecord
  end
  redirect "/questions/#{params[:id]}"
end
