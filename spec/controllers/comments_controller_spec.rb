require 'spec_helper'

describe "Comment Controller" do
  let!(:user1){ FactoryGirl.create(:user) }
  let!(:question){ FactoryGirl.create(:question) }
  let!(:answer){ FactoryGirl.create(:answer) }

# Adding comments to questions
  context 'get /comments/new route' do
    it "should respond to the /comments/new route" do
      get "/comments/new"
      expect(last_response.status).to eq(200)
    end

    it 'should display a form' do
      get "/comments/new"
      expect(last_response.body).to include('<form id=\'comment-form\'')
    end
  end

  context 'post /comments route for questions' do
    it 'should redirect if valid comment is given' do
      post "/comments", {"text"=>"comment", "commentable_type" => 'question', "commentable_id" => "#{question.id}" }
      expect(last_response.status).to eq(302)
    end

    it 'should redirect to /questions/:question_id if valid comment is given' do
      post "/comments", {"text"=>"comment", "commentable_type" => 'question', "commentable_id" => "#{question.id}" }
      expect(last_response.location).to include("/questions/#{question.id}")
    end

    it 'will create a comment in the database if a valid comment is given' do
      comment_count = question.comments.all.count
      post "/comments", {"text"=>"comment", "commentable_type" => 'question', "commentable_id" => "#{question.id}" }
      expect(question.comments.all.count).to eq (comment_count + 1)
    end

    it 'should 422 if an invalid comment is given' do
      post "/comments", {"text"=>"", "commentable_type" => 'question', "commentable_id" => "#{question.id}" }
      expect(last_response.status).to eq(422)
    end

    it 'should include the error message' do
      post "/comments", {"text"=>"", "commentable_type" => 'question', "commentable_id" => "#{question.id}" }
      expect(last_response.body).to include("Text can't be blank")
    end
  end

# Adding comments to answers

  context 'post /comments route for answers' do
    it 'should redirect if valid comment is given' do
      post "/comments", {"text"=>"comment", "commentable_type" => 'answer', "commentable_id" => "#{answer.id}" }
      expect(last_response.status).to eq(302)
    end

    it 'should redirect to /questions/:question_id if valid comment is given' do
      post "/comments", {"text"=>"comment", "commentable_type" => 'answer', "commentable_id" => "#{answer.id}" }
      expect(last_response.location).to include("/questions/#{question.id}")
    end

    it 'will create a comment in the database if a valid comment is given' do
     comment_count = answer.comments.all.count
     post "/comments", {"text"=>"comment", "commentable_type" => 'answer', "commentable_id" => "#{answer.id}" }
     expect(answer.comments.all.count).to eq (comment_count + 1)
   end

    it 'should 422 if an invalid comment is given' do
      post "/comments", {"text"=>"", "commentable_type" => 'answer', "commentable_id" => "#{answer.id}" }
      expect(last_response.status).to eq(422)
    end

    it 'should include the error message' do
      post "/comments", {"text"=>"", "commentable_type" => 'answer', "commentable_id" => "#{answer.id}" }
      expect(last_response.body).to include("Text can't be blank")
    end
  end

end
