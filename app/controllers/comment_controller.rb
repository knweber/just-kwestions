# Comments on questions
get '/questions/:question_id/comments/new' do
  erb :'comments/new', locals: { action: "questions/#{params[:question_id]}/comments" }
end

post '/questions/:question_id/comments' do
  question = Question.find(params[:question_id])
  comment = question.comments.create(text: params[:text], user_id: User.all.sample.id)

  if comment.valid?
    redirect "/questions/#{question.id}"
  else
    status 422
    erb :'comments/new', locals: { action: "questions/#{params[:question_id]}/comments", errors: comment.errors.full_messages }
  end
end

# Comments on answers
get '/questions/:question_id/answers/:answer_id/comments/new' do
  erb :'comments/new', locals: { action: "questions/#{params[:question_id]}/answers/#{params[:answer_id]}/comments" }
end

post '/questions/:question_id/answers/:answer_id/comments' do
  question = Question.find(params[:question_id])
  answer = Answer.find(params[:answer_id])
  comment = answer.comments.create(text: params[:text], user_id: User.all.sample.id)

  if comment.valid?
    redirect "/questions/#{question.id}"
  else
    status 422
    erb :'comments/new', locals: { action: "questions/#{params[:question_id]}/answers/#{params[:answer_id]}/comments", errors: comment.errors.full_messages }
  end
end
