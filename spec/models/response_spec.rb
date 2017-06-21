describe Response do
  let(:question_response) { Response.new(content: 'because you are sad?') }
  let(:no_content) { Response.new(content: '') }
  context 'validations' do
    context 'with content' do
      it 'validates presence of content' do
        expect(question_response).to be_valid
      end
    end
    context 'without content' do
      it 'is not valid' do
        expect(no_content).to_not be_valid
      end

      it 'raises an error on save' do
        expect{no_content.save!}.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end

end
