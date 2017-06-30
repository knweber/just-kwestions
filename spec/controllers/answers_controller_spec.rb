require 'spec_helper'

describe "Answer Controller" do
  let!(:question){ Question.create(text: "Help me with rspec tests", user_id: 1) }


  context 'get /questions/:question_id/answers/new route' do
    it "should respond to the /questions/:question_id/answers/new route" do
      get "/questions/#{question.id}/answers/new"
      expect(last_response.status).to eq(200)
    end

    it 'should display a form' do
      get "/questions/#{question.id}/answers/new"
      expect(last_response.body).to include('<form id=\'answer-form\'')
    end  end

  context 'post /questions/:question_id/answers route' do
    let!(:user){ User.create(username: "testuser") }
    it 'should redirect if valid question is given' do
      post "/questions/#{question.id}/answers", {"answer"=>{"text"=>'ggfhjdgfhgd', "question_id"=>question.id}}
      expect(last_response.status).to eq(302)
    end

    it 'should redirect to /questions/:question_id if valid answer is given' do
      post "/questions/#{question.id}/answers", {"answer"=>{"text"=>'ggfhjdgfhgd', "question_id"=>question.id}}
      expect(last_response.location).to include("/questions/#{question.id}")
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
