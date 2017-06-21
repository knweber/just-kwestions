describe 'ResponsesController' do
  describe 'put "/responses/:id"' do
    context 'on success' do
      it 'responds with a status of 302'
      it 'responds with the newly updated response'
    end
    context 'on failure' do
      it 'responds with a status of 200'
      it 'responds with the response edit form containing errors in the response'
      it 'adds errors to the response object'
    end
  end
  describe 'delete "/responses/:id"' do
    it 'responds with a status of 302'
    it' responds with the index page without the deleted response in the response body'
  end
  describe 'post "/responses"' do
    context 'on success' do
      it 'responds with a status of 302'
      it 'responds with the newly created response in the response body'
      it 'adds the new response to the database'
    end
    context 'on failure' do
      it 'responds with a status of 200'
      it 'responds with errors in the response body'
      it 'adds errors to the response object'
    end
  end
end
