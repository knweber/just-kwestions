require 'spec_helper'

describe "Sessions Controller" do

  context 'get /login route' do
    it "should respond to the /login route" do
      get "/login"
      expect(last_response.status).to eq(200)
    end

    it 'should display a form' do
      get "/login"
      expect(last_response.body).to include('<form class="session_form"')
    end
  end

  context ''

end
