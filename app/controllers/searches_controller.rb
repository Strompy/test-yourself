class SearchesController < ApplicationController
    def show
        if params[:query].present?
            @flashcards = Flashcard.where("question ilike ?", "%#{params[:query]}%").limit(5)
        else
            @flashcards = Flashcard.all.limit(5)
        end
    end
end
