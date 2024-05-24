# create an rspec spec for flashcards
# first test creating flashcards
# then test viewing flashcards idex
# flashcards have a question and an answer
require 'rails_helper'

RSpec.describe 'Flashcards', type: :feature do
    describe 'create' do
        it 'creates a new flashcard' do
            # navigate to the new flashcard page
            visit new_flashcard_path
            # fill in the form with the question and answer
            fill_in 'Question', with: 'What is the capital of France?'
            fill_in 'Answer', with: 'Paris'
            # click the submit button
            click_on 'Create Flashcard'
            
            expect(current_path).to eq(flashcards_path)
            expect(page).to have_content('Flashcard created successfully')
            expect(page).to have_content('What is the capital of France?')


        end
    end

    describe 'index' do
        it 'displays all flashcards' do
            # create a flash card
            Flashcard.create!(question: 'What is the capital of France?', answer: 'Paris')
            Flashcard.create!(question: 'What is the capital of Germany?', answer: 'Berlin')
            Flashcard.create!(question: 'What is the capital of Italy?', answer: 'Rome')
            # visit the flash cards index page
            visit flashcards_path
            # expect the flash card to be displayed
            expect(page).to have_content('What is the capital of France?')
            expect(page).to have_content('What is the capital of Germany?')
            expect(page).to have_content('What is the capital of Italy?')
        end
    end

    describe 'show' do
        it 'displays a single flash card' do
            # create a flash card
            flashcard = Flashcard.create!(question: 'What is the capital of France?', answer: 'Paris')
            # visit the flash card show page
            visit flashcard_path(flashcard)
            # expect the flash card to be displayed
            expect(page).to have_content('What is the capital of France?')
            expect(page).to have_content('Paris')
            # expect a link to the flash card index page
            expect(page).to have_link('Back to Flashcards', href: flashcards_path)
            # this is where we will add testing functionailty
            # answer won't be displayed automatically
            # there will be a button to show the answer
            # when the button is clicked, the answer will be displayed
            # there will be a button to say whether the user got the answer right or wrong
        end
    end

    describe 'update' do
        it 'updates a flash card' do
            # create a flash card
            flashcard = Flashcard.create!(question: 'What is the capital of France?', answer: 'Paris')
            # visit the flash card edit page
            visit edit_flashcard_path(flashcard)
            # change the question and answer
            fill_in 'Question', with: 'What is the capital of Germany?'
            fill_in 'Answer', with: 'Berlin'
            # click the submit button
            click_on 'Update Flashcard'
            # expect the flash card to be updated
            expect(current_path).to eq(flashcard_path(flashcard))
            expect(page).to have_content('Flashcard updated successfully')
            expect(page).to have_content('What is the capital of Germany?')
        end
    end

    describe 'destroy' do
        it 'deletes a flashcard' do
            # create a flashcard
            flashcard = Flashcard.create!(question: 'What is the capital of France?', answer: 'Paris')
            # visit the flashcard show page
            visit flashcard_path(flashcard)
            # click the delete button
            click_on 'Delete Flashcard'
            # expect the flashcard to be deleted
            expect(current_path).to eq(flashcards_path)
            expect(page).to have_content('Flashcard deleted successfully')
            expect(page).not_to have_content('What is the capital of France?')
        end
    end
end