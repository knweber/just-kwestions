require 'spec_helper'

describe 'Index Controller' do
  it 'should respond with a redirect' do
    get "/"
    expect(last_response.status).to eq(302)
  end

  it 'should redirect to /questions' do
    get "/"
    expect(last_response.location).to include("/questions")
  end
end
