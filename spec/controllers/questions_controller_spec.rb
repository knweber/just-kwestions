require 'spec_helper'

describe "Question Controller" do
  let!(:user1){ FactoryGirl.create(:user) }
  let!(:question){ FactoryGirl.create(:question) }
  context 'get /questions route' do
    it "should respond to the /questions route" do
      get "/questions"
      expect(last_response.status).to eq(200)
    end

    it "should display questions" do
      get "/questions"
      expect(last_response.body).to include(question.text)
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
    let!(:user){ User.create(username: "testuser", email: "test@gmail.com", password: "12345678") }
    it 'should redirect if valid question is given' do
      post "/questions", {"question"=>{"text"=>question.text}}
      expect(last_response.status).to eq(302)
    end

    it 'will create a question in the database if a valid question is given' do
      question_count = Question.all.count
      post "/questions", {"question"=>{"text"=>question.text}}
      expect(Question.all.count).to eq (question_count + 1)
    end

    it 'should redirect to /questions if valid question is given' do
      post "/questions", {"question"=>{"text"=>question.text}}
      expect(last_response.location).to include("/questions")
    end

    it 'should 422 if an invalid question is given' do
      post "/questions", {"question"=>{"text"=>""}}
      expect(last_response.status).to eq(422)
    end

    it 'should include the error message' do
      post "/questions", {"question"=>{"text"=>""}}
      expect(last_response.body).to include("Text can't be blank")
    end
  end

end
