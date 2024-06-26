class FlashcardsController < ApplicationController
    before_action :set_flashcard, only: [:show, :search, :edit, :update, :destroy]

    def index
        @flashcards = Flashcard.all
    end

    def show; end

    def random
        @flashcard = Flashcard.find_random

        redirect_to flashcard_path(@flashcard)
    rescue ActiveRecord::RecordNotFound
        redirect_to root_path, alert: 'No flashcards to quiz'
    end

    def search
        correct = @flashcard.answer.downcase == params[:guess].downcase
        message = correct ? 'Correct!' : 'Incorrect!'
        redirect_to flashcard_path(@flashcard), notice: message
    end
    
    def new
        @flashcard = Flashcard.new
    end

    def create
        @flashcard = Flashcard.new(flashcard_params)

        if @flashcard.save
            redirect_to root_path, notice: 'Flashcard created successfully'
        else
            render :new, alert: "Flashcard not created: #{flashcard.errors.full_messages.to_sentence}"
        end
    end

    def edit; end

    def update
        if @flashcard.update(flashcard_params) 
            redirect_to flashcard_path(@flashcard), notice: 'Flashcard updated successfully'
        else
            render :edit, alert: "Flashcard not updated: #{flashcard.errors.full_messages.to_sentence}"
        end
    end
    
    def destroy
        if @flashcard.destroy
            redirect_to root_path, notice: 'Flashcard deleted successfully'
        else
            redirect_to root_path, alert: "Flashcard not deleted: #{flashcard.errors.full_messages.to_sentence}"
        end
    end

    private

    def flashcard_params
        params.require(:flashcard).permit(:question, :answer)
    end

    def set_flashcard
        @flashcard = Flashcard.find(params[:id])
    end
end