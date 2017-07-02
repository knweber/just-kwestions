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
    it 'redirects with valid user info' do
      
    end

    it 'redirects to / with valid user info' do

    end

    it 'creates a user with valid user info' do

    end

    it 'displays errors with invalid user info' do

    end

  end

end
