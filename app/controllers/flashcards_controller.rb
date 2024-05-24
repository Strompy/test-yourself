class FlashcardsController < ApplicationController
    def index
        @flashcards = Flashcard.all
    end
    
    def new
        @flashcard = Flashcard.new
    end

    def create
        @flashcard = Flashcard.new(flashcard_params)

        if @flashcard.save
            redirect_to flashcards_path, notice: 'Flashcard created successfully'
        else
            render :new, notice: "Flashcard not created: #{flashcard.errors.full_messages.to_sentence}"
        end
    end

    private

    def flashcard_params
        params.require(:flashcard).permit(:question, :answer)
    end
end