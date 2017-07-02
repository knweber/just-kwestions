require 'spec_helper'

describe "Answer Controller" do
  let!(:user1){ FactoryGirl.create(:user) }
  let!(:question){ FactoryGirl.create(:question) }
  before(:each) do
    post '/sessions', { 'email' => user1.email, 'password' => '12345678' }
  end

  context 'get /questions/:question_id/answers/new route' do
    it "should respond to the /questions/:question_id/answers/new route" do
      get "/questions/#{question.id}/answers/new"
      expect(last_response.status).to eq(200)
    end

    it 'should display a form' do
      get "/questions/#{question.id}/answers/new"
      expect(last_response.body).to include('<form id=\'answer-form\'')
    end

    it 'should redirect if not logged in' do
      delete '/sessions/1'
      get "/questions/#{question.id}/answers/new"
      expect(last_response.status).to eq (302)
    end

    it 'should redirect to /questions/:question_id if not logged in' do
      delete '/sessions/1'
      get "/questions/#{question.id}/answers/new"
      expect(last_response.location).to include("/questions/#{question.id}")
    end
  end

  context 'post /questions/:question_id/answers route' do

    it 'automatically assigns user to answer' do
      p user1.id
      post "/questions/#{question.id}/answers", {"answer"=>{"text"=>'ggfhjdgfhgd', "question_id"=>question.id}}
      p question.answers.last
      expect(question.answers.last.user_id).to eq(user1.id)
    end

    it 'should redirect if valid question is given' do
      post "/questions/#{question.id}/answers", {"answer"=>{"text"=>'ggfhjdgfhgd', "question_id"=>question.id}}
      expect(last_response.status).to eq(302)
    end

    it 'should redirect to /questions/:question_id if valid answer is given' do
      post "/questions/#{question.id}/answers", {"answer"=>{"text"=>'ggfhjdgfhgd', "question_id"=>question.id}}
      expect(last_response.location).to include("/questions/#{question.id}")
    end

    it 'will create an answer in the database if a valid answer is given' do
      answer_count = Answer.all.count
      post "/questions/#{question.id}/answers", {"answer"=>{"text"=>'ggfhjdgfhgd', "question_id"=>question.id}}
      expect(Answer.all.count).to eq (answer_count + 1)
    end

    it 'should 422 if an invalid answer is given' do
      post "/questions/#{question.id}/answers", {"answer"=>{"text"=>'', "question_id"=>question.id}}
      expect(last_response.status).to eq(422)
    end

    it 'should include the error message' do
      post "/questions/#{question.id}/answers", {"answer"=>{"text"=>'', "question_id"=>question.id}}
      expect(last_response.body).to include("Text can't be blank")
    end

    it 'should redirect if no login' do
      delete '/sessions/1'
      post "/questions/#{question.id}/answers"
      expect(last_response.status).to eq(302)
    end

    it 'should redirect to /questions/:question_id if no login' do
      delete '/sessions/1'
      post "/questions/#{question.id}/answers"
      expect(last_response.location).to include("/questions/#{question.id}")
    end
  end

end
