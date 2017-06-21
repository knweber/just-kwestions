describe 'QuestionsController' do
  describe 'get "/questions"' do
    it 'responds with a status of 200' do
    end
    it 'has a question in the response body'
  end
  describe 'get "/questions/:id"' do
    it 'responds with a status of 200'
    it 'has a question in the response body'
    it 'has the associated question responses in the response body'
  end
  describe 'get "/questions/new"' do
    it 'responds with a status of 200'
    it 'has a question in the response body'
  end
  describe 'post "/questions"' do
    context 'on success' do
      it 'responds with a status of 302'
      it 'responds with the newly created question in the response body'
      it 'adds the new question to the database'
    end
    context 'on failure' do
      it 'responds with a status of 200'
      it 'responds with errors in the response body'
      it 'adds errors to the question object'
    end
  end
  describe 'get "/questions/:id/edit"' do
    it 'repsonds with a status of 200'
    it 'responds with the edit page in the response body'
  end
  describe 'put "/questions/:id"' do
    context 'on success' do
      it 'responds with a status of 302'
      it 'responds with the newly updated question'
    end
    context 'on failure' do
      it 'responds with a status of 200'
      it 'responds with the question edit form containing errors in the response'
      it 'adds errors to the question object'
    end
  end
  describe 'delete "/questions/:id"' do
    it 'responds with a status of 302'
    it' responds with the index page without the deleted question in the response body'
  end
end
