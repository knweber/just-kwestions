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

    if request.xhr?
      html = "Points: #{voteable.votes.where(upvote: 'true').count - voteable.votes.where(upvote: 'false').count}"
      if params[:voteable_type] != 'question'
        content_type :json
        return {
          id: voteable.id,
          html: html
        }.to_json
      else
        return html
      end
    end
  end
  redirect "/questions/#{params[:question_page]}"
end
