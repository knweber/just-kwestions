require_relative '../spec_helper'

describe 'question show page' do
  let!(:user1) { FactoryGirl.create(:user) }
  let(:user2) { FactoryGirl.create(:user) }
  let(:user3) { FactoryGirl.create(:user) }

  let!(:question) {
    Question.create(text: 'This is why you fail.', user_id: user1.id) }

  let!(:answer) {
    Answer.create(text: "You're a wizard, Harry.", user_id: user2.id, question_id: question.id) }

  it 'shows the question prompt' do
    get "/questions/#{question.id}"
    expect(last_response.body).to include('why you fail')
  end

  it 'shows the answer' do
    get "/questions/#{question.id}"
    expect(last_response.body).to include('wizard, Harry')
  end

  it "shows the question's comments" do
    question.comments.create(text: "Yes you are", user_id: user3.id)
    get "/questions/#{question.id}"
    expect(last_response.body).to include('you are')
  end

  it "shows the answers comments" do
    answer.comments.create(text: "Here I am.", user_id: user3.id)
    get "/questions/#{question.id}"
    expect(last_response.body).to include('I am')
  end

  it "shows the question author" do
    get "/questions/#{question.id}"
    expect(last_response.body).to include(user1.username)
  end

  it "shows the answers author" do
    get "/questions/#{question.id}"
    expect(last_response.body).to include(user2.username)
  end

  it "shows the comments author" do
    question.comments.create(text: "Yes you are", user_id: user3.id)
    get "/questions/#{question.id}"
    expect(last_response.body).to include(user3.username)
  end
end
