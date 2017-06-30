require 'spec_helper'

describe "Votes Controller" do
  let(:question){ Question.create(text: "this is a question?", user_id: 1)}
  context 'vote buttons appear on questions show page' do
    it "should show an upvote button" do
      get "/questions/#{question.id}"
      expect(last_response.body).to include('name="upvote-question"')
    end

    it "should NOT show a downvote button if there are no votes" do
      get "/questions/#{question.id}"
      expect(last_response.body).not_to include('name="downvote-question"')
    end

    it "should show a downvote button if there are votes" do
      question.votes.create(user_id: 2)
      get "/questions/#{question.id}"
      expect(last_response.body).to include('name="downvote-question"')
    end

  end

  context 'post /questions/:question_id/votes route' do
    it 'should redirect if question is upvoted' do
      post "/questions/1/votes"
      expect(last_response.status).to eq(302)
    end

    it 'should redirect to /questions/:question_id if question is upvoted' do
      post "/questions/1/votes"
      expect(last_response.location).to include("/questions/1")
    end

    it 'will create a vote for question in the database if a question is upvoted' do
       vote_count = question.votes.count
       post "/questions/#{question.id}/votes"
       expect(question.votes.count).to eq (vote_count + 1)
     end
  end

  context 'delete /questions/:question_id/votes/:id route' do
    it 'should redirect if question is downvoted' do
      question.votes.create(user_id: 2)
      delete "/questions/#{question.id}/votes/ham"
      expect(last_response.status).to eq(302)
    end

    it 'should redirect to /questions/:question_id if question is downvoted' do
      question.votes.create(user_id: 2)
      delete "/questions/#{question.id}/votes/ham"
      expect(last_response.location).to include("/questions/#{question.id}")
    end

    it 'will delete a vote for question in the database if a question is downvoted' do
      question.votes.create(user_id: 2)
      vote_count = question.votes.count
      delete "/questions/#{question.id}/votes/ham"
      expect(question.votes.count).to eq (vote_count - 1)
     end
  end
end
