require 'spec_helper'

describe "Question Controller" do
  let!(:question){ Question.create(prompt: "Help me with rspec tests", user_id: 1) }
  context 'get /questions route' do
    it "should respond to the /questions route" do
      get "/questions"
      expect(last_response.status).to eq(200)
    end

    it "should display questions" do
      get "/questions"
      expect(last_response.body).to include(question.prompt)
    end

    it "should display each question as a link" do
      get "/questions"
      expect(last_response.body).to include("<a href=\"/questions/#{question.id}\"")
    end
  end

  context 'get /questions/new route' do
    it "should respond to the /questions/new route" do
      get "/questions/new"
      expect(last_response.status).to eq(200)
    end

    it 'should display a form' do
      get "/questions/new"
      expect(last_response.body).to include('<form id=\'question-form\'')
    end
  end

  context 'post /questions route' do
    let!(:user){ User.create(username: "testuser") }
    it 'should redirect if valid question is given' do
      post "/questions", {"question"=>{"prompt"=>question.prompt}}
      expect(last_response.status).to eq(302)
    end

    it 'should redirect to /questions if valid question is given' do
      post "/questions", {"question"=>{"prompt"=>question.prompt}}
      expect(last_response.location).to include("/questions")
    end

    it 'should 422 if an invalid question is given' do
      post "/questions", {"question"=>{"prompt"=>""}}
      expect(last_response.status).to eq(422)
    end

    it 'should include the error message' do
      post "/questions", {"question"=>{"prompt"=>""}}
      expect(last_response.body).to include("Prompt can't be blank")
    end
  end

end
