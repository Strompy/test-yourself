class FlashcardsController < ApplicationController
    def index
        @flashcards = Flashcard.all
    end

    def show
        @flashcard = Flashcard.find(params[:id])
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

    def edit
        @flashcard = Flashcard.find(params[:id])
    end

    def update
        @flashcard = Flashcard.find(params[:id])
        if @flashcard.update(flashcard_params) 
            redirect_to flashcard_path(@flashcard), notice: 'Flashcard updated successfully'
        else
            render :edit, notice: "Flashcard not updated: #{flashcard.errors.full_messages.to_sentence}"
        end
    end
    
    def destroy
        Flashcard.destroy(params[:id])
        redirect_to flashcards_path, notice: 'Flashcard deleted successfully'
    end

    private

    def flashcard_params
        params.require(:flashcard).permit(:question, :answer)
    end
end