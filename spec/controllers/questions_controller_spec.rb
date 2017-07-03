require 'spec_helper'

describe "Question Controller" do
  let!(:user1){ FactoryGirl.create(:user) }
  let!(:question){ FactoryGirl.create(:question) }

  before(:each) do
    post '/sessions', { 'email' => user1.email, 'password' => '12345678' }
  end

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

    it 'should redirect if a user is not logged in' do
      delete '/sessions/1'
      get '/questions/new'
      expect(last_response.status).to eq 302
    end

    it 'should display a form' do
      get "/questions/new"
      expect(last_response.body).to include('<form id=\'question-form\'')
    end
  end

  context 'post /questions route' do
    it 'should redirect if valid question is given' do
      post "/questions", {"question"=>{"text"=>question.text}}
      expect(last_response.status).to eq(302)
    end

    it 'automatically assigns user to question' do
      post "/questions", {"question"=>{"text"=>question.text}}
      expect(question.user_id).to eq(user1.id)
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

  context 'the best' do
    let!(:answer){ FactoryGirl.create(:answer) }
    it 'should set the selected answer as the best' do
      put "/questions/#{question.id}", { "answer_id" => answer.id }
      question.reload
      expect(question.best_answer).to eq answer
    end

    it 'should redirect' do
      put "/questions/#{question.id}", { "answer_id" => answer.id }
      expect(last_response.status).to eq 302
    end

    it 'should redirect to /questions/:id' do
      put "/questions/#{question.id}", { "answer_id" => answer.id }
      expect(last_response.location).to include("/questions/#{question.id}")
    end

    it 'should update the best answer even if there is one already selected' do
      put "/questions/#{question.id}", { "answer_id" => answer.id }
      answer2 = FactoryGirl.create(:answer)
      put "/questions/#{question.id}", { "answer_id" => answer2.id }
      question.reload
      expect(question.best_answer).to eq answer2
    end
  end

end
