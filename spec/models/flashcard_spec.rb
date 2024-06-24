require 'rails_helper'

RSpec.describe Flashcard, type: :model do
  context 'Validations' do
    it { should validate_presence_of :question }
    it { should validate_presence_of :answer }
  end

  context 'query methods' do
    describe '.find_random' do
      it 'returns a flashcard' do
        flashcard = Flashcard.create!(question: 'What is the capital of France?', answer: 'Paris')
        expect(Flashcard.find_random).to eq(flashcard)
      end

      it 'raises an error if no flashcards exist' do
        expect { Flashcard.find_random }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
    
    describe '.find_or_next' do
      it 'returns a flashcard' do
        flashcard = Flashcard.create!(question: 'What is the capital of France?', answer: 'Paris')
        expect(Flashcard.find_or_next(flashcard.id)).to eq(flashcard)
      end

      it 'raises an error if no flashcards exist' do
        expect { Flashcard.find_or_next(1) }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
