describe 'user controller' do

  context 'get /users/new' do
      it 'handles the route' do
        get '/users/new'
        expect(last_response.status).to eq 200
      end

      it 'displays a form' do
        get '/users/new'
        expect(last_response.body).to include('form id="session_form"')
      end
  end

  context 'post /users route' do
    let!(:user_params) { { 'user' => { 'username' => 'Terry', 'email' => 'terry@gmail.com', 'password' => '12345678' } } }
    it 'redirects with valid user info' do
      post '/users', user_params
      expect(last_response.status).to eq 302
    end

    it 'redirects to / with valid user info' do
      post '/users', user_params
      # COME BACK TO THIS IF TIME PERMITS
      expect(last_response.location).to include('/')
    end

    it 'creates a user with valid user info' do
      user_count = User.all.count
      post '/users', user_params
      expect(User.all.count).to eq (user_count +1)
    end

    it 'displays errors with invalid user info' do
      post '/users', { 'user' => { 'username' => 'Terry', 'email' => 'terry@gmail.com', 'password' => '123456' } }
      expect(last_response.body).to include('provide password of at least 8')
    end

  end

end
