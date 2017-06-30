require 'spec_helper'

describe "Comment Controller" do
  let(:question){ Question.create(text: "this is a question?", user_id: 1)}
  context 'get /questions/:question_id/comments/new route' do
    it "should respond to the /questions/:question_id/comments/new route" do
      get "/questions/1/comments/new"
      expect(last_response.status).to eq(200)
    end

    it 'should display a form' do
      get "/questions/1/comments/new"
      expect(last_response.body).to include('<form id=\'comment-form\'')
    end
  end

  context 'post /questions/:question_id/comments route' do
    let!(:user){ User.create(username: "testuser") }
    it 'should redirect if valid comment is given' do
      post "/questions/1/comments", {"text"=>"comment"}
      expect(last_response.status).to eq(302)
    end

    it 'should redirect to /questions/:question_id if valid question is given' do
      post "/questions", {"text"=>"comment"}
      expect(last_response.location).to include("/questions/1")
    end

    it 'will create a comment in the database if a valid comment is given' do
       comment_count = question.comments.all.count
       post "/questions/1/comments", {"text"=>"comment"}
       expect(question.comments.all.count).to eq (comment_count + 1)
     end

    it 'should 422 if an invalid comment is given' do
      post "/questions/1/comments", {"text"=>""}
      expect(last_response.status).to eq(422)
    end

    it 'should include the error message' do
      post "/questions/1/comments", {"text"=>""}
      expect(last_response.body).to include("Text can't be blank")
    end
  end
end
