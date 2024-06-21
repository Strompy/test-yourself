require 'rails_helper'

RSpec.describe 'Flashcards', type: :feature do
    describe 'create' do
        it 'creates a new flashcard' do
            visit root_path
            click_on 'New flashcard'

            fill_in 'Question', with: 'What is the capital of France?'
            fill_in 'Answer', with: 'Paris'
            click_on 'Submit'
            
            expect(current_path).to eq(root_path)
            expect(page).to have_content('Flashcard created successfully')
            expect(page).to have_content('What is the capital of France?')


        end
    end

    describe 'index' do
        it 'displays all flashcards' do
            Flashcard.create!(question: 'What is the capital of France?', answer: 'Paris')
            Flashcard.create!(question: 'What is the capital of Germany?', answer: 'Berlin')
            Flashcard.create!(question: 'What is the capital of Italy?', answer: 'Rome')
            visit root_path

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
            expect(page).to have_link('Back to flashcards', href: root_path)
        end
    end
    describe 'reveal', js: true, driver: :selenium_chrome_headless do
        it 'displays the answer when clicked' do
            flashcard = Flashcard.create!(question: 'What is the capital of France?', answer: 'Paris')
            visit flashcard_path(flashcard)

            expect(page).to have_content('What is the capital of France?')
            expect(page).to_not have_content('Paris')
            find('#reveal-btn').click

            expect(page).to have_content('Paris')           
        end
    end

    describe 'random' do
        it 'grabs a random flash card and redirects to show' do
            Flashcard.create!(question: 'What is the capital of France?', answer: 'Paris')
            Flashcard.create!(question: 'What is the capital of Germany?', answer: 'Berlin')
            Flashcard.create!(question: 'What is the capital of Italy?', answer: 'Rome')
            visit root_path
            click_on 'Quiz me!'
            expect(page).to have_content('What is the capital of')
            click_on 'Quiz me!'
            expect(page).to have_content('What is the capital of')
        end
        it 'handles no flashcards' do
            visit root_path
            click_on 'Quiz me!'
            expect(page).to have_content('No flashcards to quiz')
        end
        it 'handles deleted id' do
            flashcard = Flashcard.create!(question: 'What is the capital of France?', answer: 'Paris')
            flashcard.destroy
            visit random_flashcards_path
            expect(page).to have_content('No flashcards to quiz')
            # maybe create a new card and check it always gets that card?
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

            expect(current_path).to eq(root_path)
            expect(page).to have_content('Flashcard deleted successfully')
            expect(page).not_to have_content('What is the capital of France?')
        end
    end
end