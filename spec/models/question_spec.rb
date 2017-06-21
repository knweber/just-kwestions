describe Question do
  let(:question) { Question.new(prompt: 'Why must I cry?') }
  let(:no_prompt) { Question.new(prompt: '') }
  context 'validations' do
    context 'with a prompt' do
      it 'validates presence of prompt' do
        expect(question).to be_valid
      end
    end
    context 'without a prompt' do
      it 'is not valid' do
        expect(no_prompt).to_not be_valid
      end

      it 'raises an error on save' do
        expect{no_prompt.save!}.to raise_error
      end
    end
  end
end
