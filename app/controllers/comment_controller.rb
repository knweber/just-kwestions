# Comments on questions
get '/comments/new' do
  if session[:user_id]
    erb :'comments/new', locals: { action: "comments", commentable_type: params[:commentable_type], commentable_id: params[:commentable_id] }
  else
    if params[:commentable_type] == 'question'
      redirect "/questions/#{params[:commentable_id]}"
    else
      question_id = Answer.find(params[:commentable_id]).question.id
      redirect "/questions/#{question_id}"
    end
  end
end

post '/comments' do
  if !session[:user_id]
    if params[:commentable_type] == 'question'
      redirect "/questions/#{params[:commentable_id]}"
    else
      question_id = Answer.find(params[:commentable_id]).question.id
      redirect "/questions/#{question_id}"
    end
  end
  if params[:commentable_type] == 'question'
    commentable = Question.find(params[:commentable_id])
  else
    commentable = Answer.find(params[:commentable_id])
  end
  comment = commentable.comments.create(text: params[:text], user_id: User.all.sample.id)
  if comment.valid?
    if params[:commentable_type] == 'question'
      redirect "/questions/#{commentable.id}"
    else
      redirect "/questions/#{commentable.question.id}"
    end
  else
    status 422
    erb :'comments/new', locals: { action: "comments", errors: comment.errors.full_messages, commentable_type: params[:commentable_type], commentable_id: params[:commentable_id]}
  end
end
