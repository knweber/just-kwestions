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
