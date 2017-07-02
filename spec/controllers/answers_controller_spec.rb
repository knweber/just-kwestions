require 'spec_helper'

describe "Answer Controller" do
  let!(:user1){ FactoryGirl.create(:user) }
  let!(:question){ FactoryGirl.create(:question) }

  context 'get /questions/:question_id/answers/new route' do
    it "should respond to the /questions/:question_id/answers/new route" do
      get "/questions/#{question.id}/answers/new"
      expect(last_response.status).to eq(200)
    end

    it 'should display a form' do
      get "/questions/#{question.id}/answers/new"
      expect(last_response.body).to include('<form id=\'answer-form\'')
    end
  end

  context 'post /questions/:question_id/answers route' do
    let!(:user){ User.create(username: "testuser", email: "test@gmail.com", password: "12345678") }
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
  end

end
