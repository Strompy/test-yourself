# create an rspec spec for flashcards
# first test creating flashcards
# then test viewing flashcards idex
# flashcards have a question and an answer
require 'rails_helper'

RSpec.describe 'Flashcards', type: :feature do
    describe 'create' do
        it 'creates a new flashcard' do
            visit flashcards_path
            click_on 'New flashcard'

            fill_in 'Question', with: 'What is the capital of France?'
            fill_in 'Answer', with: 'Paris'
            click_on 'Submit'
            
            expect(current_path).to eq(flashcards_path)
            expect(page).to have_content('Flashcard created successfully')
            expect(page).to have_content('What is the capital of France?')


        end
    end

    describe 'index' do
        it 'displays all flashcards' do
            Flashcard.create!(question: 'What is the capital of France?', answer: 'Paris')
            Flashcard.create!(question: 'What is the capital of Germany?', answer: 'Berlin')
            Flashcard.create!(question: 'What is the capital of Italy?', answer: 'Rome')
            visit flashcards_path

            expect(page).to have_content('What is the capital of France?')
            expect(page).to have_content('What is the capital of Germany?')
            expect(page).to have_content('What is the capital of Italy?')
        end
    end

    describe 'show' do
        it 'displays a single flash card' do
            flashcard = Flashcard.create!(question: 'What is the capital of France?', answer: 'Paris')
            visit flashcard_path(flashcard)

            expect(page).to have_content('What is the capital of France?')
            expect(page).to have_content('Paris')
            expect(page).to have_link('Back to flashcards', href: flashcards_path)
            
            # answer won't be displayed automatically
            # there will be a button to show the answer
            # when the button is clicked, the answer will be displayed
            # there will be a button to say whether the user got the answer right or wrong
        end
    end

    describe 'update' do
        it 'updates a flash card' do
            flashcard = Flashcard.create!(question: 'What is the capital of France?', answer: 'Paris')
            visit edit_flashcard_path(flashcard)
            fill_in 'Question', with: 'What is the capital of Germany?'
            fill_in 'Answer', with: 'Berlin'
            click_on 'Submit'

            expect(current_path).to eq(flashcard_path(flashcard))
            expect(page).to have_content('Flashcard updated successfully')
            expect(page).to have_content('What is the capital of Germany?')
        end
    end

    describe 'destroy' do
        it 'deletes a flashcard' do
            flashcard = Flashcard.create!(question: 'What is the capital of France?', answer: 'Paris')
            visit flashcard_path(flashcard)
            click_on 'Delete'

            expect(current_path).to eq(flashcards_path)
            expect(page).to have_content('Flashcard deleted successfully')
            expect(page).not_to have_content('What is the capital of France?')
        end
    end
end