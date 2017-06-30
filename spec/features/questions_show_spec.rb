require_relative '../spec_helper'

describe 'question show page' do
  let!(:user1) { FactoryGirl.create(:user) }
  let(:user2) { FactoryGirl.create(:user) }
  let(:user3) { FactoryGirl.create(:user) }

  let!(:question) { FactoryGirl.create(:question) }

  let!(:answer) { FactoryGirl.create(:answer) }

  it 'shows the question prompt' do
    get "/questions/#{question.id}"
    expect(last_response.body).to include(question.text)
  end

  it 'shows the answer' do
    get "/questions/#{question.id}"
    expect(last_response.body).to include(answer.text)
  end

  it "shows the question's comments" do
    comment = FactoryGirl.create(:comment)
    question.comments << comment
    get "/questions/#{question.id}"
    expect(last_response.body).to include(comment.text)
  end

  it "shows the answers comments" do
    comment = FactoryGirl.create(:comment)
    answer.comments << comment
    get "/questions/#{question.id}"
    expect(last_response.body).to include(comment.text)
  end

  it "shows the question author" do
    get "/questions/#{question.id}"
    expect(last_response.body).to include(question.user.username)
  end

  it "shows the answers author" do
    get "/questions/#{question.id}"
    expect(last_response.body).to include(question.user.username)
  end

  it "shows the comments author" do
    comment = FactoryGirl.create(:comment)
    question.comments << comment
    get "/questions/#{question.id}"
    expect(last_response.body).to include(question.comments.first.user.username)
  end
end
