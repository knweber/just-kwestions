require 'spec_helper'

describe "Question Controller" do
  let!(:question){ Question.create(prompt: "Help me with rspec tests", user_id: 1) }
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
