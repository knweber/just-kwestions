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

  # context 'post /questions/:question_id/comments route' do
  #   let!(:user){ User.create(username: "testuser") }
  #   it 'should redirect if valid comment is given' do
  #     post "/questions/1/comments", {"text"=>"comment"}
  #     expect(last_response.status).to eq(302)
  #   end
  #
  #   it 'should redirect to /questions/:question_id if valid question is given' do
  #     post "/questions/1/comments", {"text"=>"comment"}
  #     expect(last_response.location).to include("/questions/1")
  #   end
  #
  #   it 'will create a comment in the database if a valid comment is given' do
  #      comment_count = question.comments.all.count
  #      post "/questions/#{question.id}/comments", {"text"=>"comment"}
  #      expect(question.comments.all.count).to eq (comment_count + 1)
  #    end
  #
  #   it 'should 422 if an invalid comment is given' do
  #     post "/questions/1/comments", {"text"=>""}
  #     expect(last_response.status).to eq(422)
  #   end
  #
  #   it 'should include the error message' do
  #     post "/questions/1/comments", {"text"=>""}
  #     expect(last_response.body).to include("Text can't be blank")
  #   end
  # end
end
