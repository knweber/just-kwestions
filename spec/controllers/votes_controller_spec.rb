require 'spec_helper'

describe "Votes Controller" do
  let!(:user1){ FactoryGirl.create(:user) }
  let!(:user2){ FactoryGirl.create(:user) }
  let!(:question){ Question.create(text: "this is a question?", user_id: user1.id)}
  let!(:answer) { Answer.create(text: 'yes it is', user_id: user2.id, question_id: question.id)}
  let!(:question_comment) { question.comments.create(text: 'good idea', user_id: user1.id)}
  let!(:answer_comment) { answer.comments.create(text: 'sounds good', user_id: user2.id)}


  context 'logged out user' do
    before(:each) do
      post '/sessions', { 'email' => user1.email, 'password' => '12345678' }
      delete '/sessions/1'
    end

    context 'vote buttons do not appear on questions show page if logged out' do

      it "should not show an upvote question button" do
        get "/questions/#{question.id}"
        expect(last_response.body).not_to include('name="upvote-question"')
      end

      it "should not show a downvote question button" do
        get "/questions/#{question.id}"
        expect(last_response.body).not_to include('name="downvote-question"')
      end

      it "should not show an upvote answer button" do
        get "/questions/#{question.id}"
        expect(last_response.body).not_to include('name="upvote-answer"')
      end

      it "should not show a downvote answer button" do
        get "/questions/#{question.id}"
        expect(last_response.body).not_to include('name="downvote-answer"')
      end

      it "should not show an upvote comment button for a question" do
        get "/questions/#{question.id}"
        expect(last_response.body).not_to include('name="upvote-question-comment"')
      end

      it "should not show a downvote comment button for a question" do
        get "/questions/#{question.id}"
        expect(last_response.body).not_to include('name="downvote-question-comment"')
      end

      it "should not show an upvote comment button for an answer" do
        get "/questions/#{question.id}"
        expect(last_response.body).not_to include('name="upvote-answer-comment"')
      end

      it "should not show a downvote comment button for an answer" do
        get "/questions/#{question.id}"
        expect(last_response.body).not_to include('name="downvote-answer-comment"')
      end

    end
  end


  context 'logged in user' do
    before(:each) do
      post '/sessions', { 'email' => user1.email, 'password' => '12345678' }
    end

    context 'vote buttons appear on questions show page if logged in' do

      it "should show an upvote question button" do
        get "/questions/#{question.id}"
        expect(last_response.body).to include('name="upvote-question"')
      end

      it "should show a downvote question button" do
        get "/questions/#{question.id}"
        expect(last_response.body).to include('name="downvote-question"')
      end

      it "should show an upvote answer button" do
        get "/questions/#{question.id}"
        expect(last_response.body).to include('name="upvote-answer"')
      end

      it "should show a downvote answer button" do
        get "/questions/#{question.id}"
        expect(last_response.body).to include('name="downvote-answer"')
      end

      it "should show an upvote comment button for a question" do
        get "/questions/#{question.id}"
        expect(last_response.body).to include('name="upvote-question-comment"')
      end

      it "should show a downvote comment button for a question" do
        get "/questions/#{question.id}"
        expect(last_response.body).to include('name="downvote-question-comment"')
      end

      it "should show an upvote comment button for an answer" do
        get "/questions/#{question.id}"
        expect(last_response.body).to include('name="upvote-answer-comment"')
      end

      it "should show a downvote comment button for an answer" do
        get "/questions/#{question.id}"
        expect(last_response.body).to include('name="downvote-answer-comment"')
      end

    end

    context 'post /votes route for upvoting questions' do
      it 'should redirect if question is upvoted' do
        post "/votes", {"voteable_type" => 'question', "voteable_id" => "#{question.id}", "upvote" => 'true', "question_page" => "#{question.id}" }
        expect(last_response.status).to eq(302)
      end

      it 'should redirect to /questions/:question_id if question is upvoted' do
        post "/votes", {"voteable_type" => 'question', "voteable_id" => "#{question.id}", "upvote" => 'true', "question_page" => "#{question.id}" }
        expect(last_response.location).to include("/questions/#{question.id}")
      end

      it 'will create a vote for question in the database if a question is upvoted' do
        vote_count = question.votes.where(upvote: 'true').count
        post "/votes", {"voteable_type" => 'question', "voteable_id" => "#{question.id}", "upvote" => 'true', "question_page" => "#{question.id}" }
        expect(question.votes.count).to eq (vote_count + 1)
      end

      it 'automatically assigns user to upvote on comment' do
        post "/votes", { "voteable_type" => 'comment', "voteable_id" => "#{question_comment.id}", "upvote" => 'true', "question_page" => "#{question.id}" }
        expect(question_comment.votes.last.user_id).to eq(user1.id)
      end
      it 'will not create a new vote if question was already upvoted by the user' do
        post "/votes", {"voteable_type" => 'question', "voteable_id" => "#{question.id}", "upvote" => 'true', "question_page" => "#{question.id}" }
        vote_count = question.votes.where(upvote: 'true').count
        post "/votes", {"voteable_type" => 'question', "voteable_id" => "#{question.id}", "upvote" => 'true', "question_page" => "#{question.id}" }
        expect(question.votes.count).to eq vote_count
      end
    end

    context 'post /votes route for downvoting questions' do
      it 'should redirect if question is downvoted' do
        post "/votes", {"voteable_type" => 'question', "voteable_id" => "#{question.id}", "upvote" => 'false', "question_page" => "#{question.id}" }
        expect(last_response.status).to eq(302)
      end

      it 'should redirect to /questions/:question_id if question is downvoted' do
        post "/votes", {"voteable_type" => 'question', "voteable_id" => "#{question.id}", "upvote" => 'false', "question_page" => "#{question.id}" }
        expect(last_response.location).to include("/questions/#{question.id}")
      end

      it 'will create a vote for question in the database if a question is downvoted' do
        vote_count = question.votes.where(upvote: 'false').count
        post "/votes", {"voteable_type" => 'question', "voteable_id" => "#{question.id}", "upvote" => 'false', "question_page" => "#{question.id}" }
        expect(question.votes.count).to eq (vote_count + 1)
      end
      it 'automatically assigns user to downvote on comment' do
        post "/votes", { "voteable_type" => 'comment', "voteable_id" => "#{question_comment.id}", "upvote" => 'false', "question_page" => "#{question.id}" }
        expect(question_comment.votes.last.user_id).to eq(user1.id)
      end


      it 'will not create a new vote if question was already downvoted by the user' do
        post "/votes", {"voteable_type" => 'question', "voteable_id" => "#{question.id}", "upvote" => 'false', "question_page" => "#{question.id}" }
        vote_count = question.votes.where(upvote: 'false').count
        post "/votes", {"voteable_type" => 'question', "voteable_id" => "#{question.id}", "upvote" => 'false', "question_page" => "#{question.id}" }
        expect(question.votes.count).to eq vote_count
      end
    end

    context 'changing vote' do
      it 'will change the vote upvote status if the user votes the other way' do
        post "/votes", {"voteable_type" => 'question', "voteable_id" => "#{question.id}", "upvote" => 'true', "question_page" => "#{question.id}" }
        vote = question.votes.last
        post "/votes", {"voteable_type" => 'question', "voteable_id" => "#{question.id}", "upvote" => 'false', "question_page" => "#{question.id}" }
        vote.reload
        expect(vote.upvote).to eq false
      end
    end

  end
end
