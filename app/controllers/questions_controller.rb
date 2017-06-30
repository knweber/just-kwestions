get '/questions' do
  @questions = Question.order(created_at: :asc)
  erb :'/questions/index'
end

get '/questions/new' do
  erb :'questions/new'
end

get '/questions/:id' do
  @question = Question.find(params[:id])
  @answers = @question.answers
  @question_comments = @question.comments
  erb :'questions/show'
end

post '/questions' do
  question_params = params[:question]
  question_params[:user_id] = User.all.sample.id
  question = Question.create(question_params)
  if question.valid?
    redirect '/questions'
  else
    status 422
    erb :'questions/new', locals: { errors: question.errors.full_messages }
  end
end