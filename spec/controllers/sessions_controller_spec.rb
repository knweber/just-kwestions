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

  context 'post /login route' do
    let!(:user) { FactoryGirl.create(:user) }
    it 'redirects if it gets valid user info' do
      post '/login', { 'email' => user.email, 'password' => '12345678' }
      expect(last_response.status).to eq 302
    end

    it 'redirects to /' do
      post '/login', { 'email' => user.email, 'password' => '12345678' }
      # COME BACK TO THIS IF TIME PERMITS
      expect(last_response.location).to include('/')
    end

    it 'gives errors if it gets invalid user info' do
      post '/login', { 'email' => user.email, 'password' => '123456' }
      expect(last_response.body).to include('Invalid email address or password.')
    end

    it 'gives a 422 if it gets invalid user info' do
      post '/login', { 'email' => user.email, 'password' => '123456' }
      expect(last_response.status).to eq 422
    end

  end

  context 'post /logout route' do
    it 'redirects' do

    end

    it 'redirects to /' do

    end

    it 'clears session' do

    end

  end

end
