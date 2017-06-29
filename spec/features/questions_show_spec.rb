require_relative '../spec_helper'

describe 'question show page' do
  let!(:question) { Question.create(prompt: 'This is why you fail.', user_id: 1) }
  let!(:answer) { Answer.create(answer: "You're a wizard, Harry.", user_id: 2, question_id: 1) }
  let!()

  it 'shows the question promt' do
    get '/questions/1'
    expect(last_response.body).to include('why you fail')
  end

  it 'shows the answer' do
    get '/questions/1'
    expect(last_response.body).to include('wizard, Harry')
  end

  it "shows the question's comments" do
    question.comments.create(comment: "Yes you are", user_id: 3)
    expect(last_response.body).to include('you are')
  end

end
