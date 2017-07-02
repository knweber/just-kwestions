require 'spec_helper'

describe "Sessions Controller" do
  let!(:user) { FactoryGirl.create(:user) }

  context 'get /sessions/new route' do
    it "should respond to the /sessions/new route" do
      get "/sessions/new"
      expect(last_response.status).to eq(200)
    end

    it 'should display a form' do
      get "/sessions/new"
      expect(last_response.body).to include('<form class="session_form"')
    end
  end

  context 'post /sessions route' do
    it 'redirects if it gets valid user info' do
      post '/sessions', { 'email' => user.email, 'password' => '12345678' }
      expect(last_response.status).to eq 302
    end

    it 'redirects to /' do
      post '/sessions', { 'email' => user.email, 'password' => '12345678' }
      # COME BACK TO THIS IF TIME PERMITS
      expect(last_response.location).to include('/')
    end

    it 'gives errors if it gets invalid user info' do
      post '/sessions', { 'email' => user.email, 'password' => '123456' }
      expect(last_response.body).to include('Invalid email address or password.')
    end

    it 'gives a 422 if it gets invalid user info' do
      post '/sessions', { 'email' => user.email, 'password' => '123456' }
      expect(last_response.status).to eq 422
    end

  end

  context 'delete /sessions/:id route' do
    before(:each) do
      post '/sessions', { 'email' => user.email, 'password' => '12345678' }
    end

    it 'redirects' do
      delete '/sessions/1'
      expect(last_response.status).to eq 302
    end

    it 'redirects to /' do
      delete '/sessions/1'
      expect(last_response.location).to include('/')
    end

    it 'clears session' do
      session = {}
      delete '/sessions/1', 'rack.session' => session
      expect(session[:user_id]).to be nil
    end

  end

end
