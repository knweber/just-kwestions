describe 'QuestionsController' do
  let(:question) { Question.create(prompt: 'Why so much ham?')}
  let(:new_question) { Question.new(prompt: 'Is it really worth it?') }
  let(:response) { Response.creat(content: 'because ham is fun to say.', question_id: question.id)}
  describe 'get "/questions"' do
    before(:each) do
      get '/questions'
    end
    it 'responds with a status of 200' do
      expect(last_response.status).to eq(200)
    end
    it 'has a question in the response body' do
      expect(last_response.body).to include(question.prompt)
    end
  end
  describe 'get "/questions/:id"' do
    before(:each) do
      get '/questions', {id: 1}
    end
    it 'responds with a status of 200' do
      expect(last_response.status).to eq(200)
    end
    it 'has a question in the response body' do
      expect(last_response.body).to include(question.prompt)
    end
    it 'has the associated question responses in the response body' do
      expect(last_response.body).to include(question.answers[1].contest)
    end
  end
  describe 'get "/questions/new"' do
    before(:each) do
      get '/questions/new'
    end
    it 'responds with a status of 200' do
      expect(last_response.status).to eq(200)
    end
    it 'has a question form in the response body' do
      expect(last_response.body).to include('Make a new question!')
    end
  end
  describe 'post "/questions"' do
    context 'on success' do
      before(:each) do
        post '/questions', {question: {prompt: new_question.prompt}}
      end
      it 'responds with a status of 302' do
        expect(last_response.status).to eq(302)
      end
      it 'responds with the newly created question in the response body' do
        expect(last_response).to include(new_question.prompt)
      end
      it 'adds the new question to the database' do
        expect(Question.last).to eq(new_question)
      end
    end
    context 'on failure' do
      before(:each) do
        post '/questions', {}
      end
      it 'responds with a status of 200' do
        expect(last_response.status).to eq(200)
      end
      it 'responds with errors in the response body' do
        expect(last_response.body).to include("can't be blank")
      end
    end
  end
  describe 'get "questions/:id/edit"' do
    before(:each) do
      get "questions/#{question.id}/edit"
    end
    it 'responds with a status of 200' do
      expect(last_response.status).to eq(200)
    end
    it 'responds with the edit page in the response body' do
      expect(last_response.body).to include('Edit your question')
    end
  end
  describe 'put "questions/:id"' do
    context 'on success' do
      before(:each) do
        put "/questions/#{question.id}", {prompt: 'Big ol sammich'}
      end
      it 'responds with a status of 302' do
        expect(last_response.status).to eq(302)
      end
      it 'responds with the newly updated question' do
        expect(last_response.body).to include('sammich')
      end
    end
    context 'on failure' do
      before(:each) do
        put "/questions/#{question.id}"
      end
      it 'responds with a status of 200' do
        expect(last_response.status).to eq(200)
      end
      it 'responds with the question edit form containing errors in the response' do
        expect(last_response.body).to include("can't be blank")
      end
    end
  end
  describe 'delete "/questions/:id"' do
    before(:each) do
      delete "questions/#{question.id}"
    end
    it 'responds with a status of 302' do
      expect(last_response.status).to eq(302)
    end
    it' responds with the index page without the deleted question in the response body' do
      expect(last_response.body).to_not include(question.prompt)
    end
  end
end
