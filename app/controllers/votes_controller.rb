post '/votes' do
  if session[:user_id] != nil
    if params[:voteable_type] == 'question'
      voteable = Question.find(params[:voteable_id])
    elsif params[:voteable_type] == 'answer'
      voteable = Answer.find(params[:voteable_id])
    else
      voteable = Comment.find(params[:voteable_id])
    end
    vote = voteable.votes.create(user_id: session[:user_id], upvote: params[:upvote])
    if !vote.valid?
      existing_vote = voteable.votes.find_by(user_id: session[:user_id])
      existing_vote.update_attributes(upvote: params[:upvote])
    end
    redirect "/questions/#{params[:question_page]}"
  else
    redirect "/questions/#{params[:question_page]}"
  end
end
