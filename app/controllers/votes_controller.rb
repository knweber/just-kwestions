post '/votes' do
  if params[:voteable_type] == 'question'
    voteable = Question.find(params[:voteable_id])
  elsif params[:voteable_type] == 'answer'
    voteable = Answer.find(params[:voteable_id])
  else
    voteable = Comment.find(params[:voteable_id])
  end
  voteable.votes.create(user_id: User.all.sample.id, upvote: params[:upvote])

  redirect "/questions/#{params[:question_page]}"

end
