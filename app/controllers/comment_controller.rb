# Comments on questions
get '/comments/new' do
  erb :'comments/new', locals: { action: "comments", commentable_type: params[:commentable_type], commentable_id: params[:commentable_id] }
end

post '/comments' do
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

# Comments on answers

#
# post '/questions/:question_id/answers/:answer_id/comments' do
#   question = Question.find(params[:question_id])
#   answer = Answer.find(params[:answer_id])
#   comment = answer.comments.create(text: params[:text], user_id: User.all.sample.id)
#
#   if comment.valid?
#     redirect "/questions/#{question.id}"
#   else
#     status 422
#     erb :'comments/new', locals: { action: "questions/#{params[:question_id]}/answers/#{params[:answer_id]}/comments", errors: comment.errors.full_messages }
#   end
# end
