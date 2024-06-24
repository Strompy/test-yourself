class Flashcard < ApplicationRecord
    validates :question, presence: true
    validates :answer, presence: true

    def self.find_random
        min = Flashcard.minimum(:id)
        max = Flashcard.maximum(:id)
        raise ActiveRecord::RecordNotFound if min.nil? || max.nil? 

        id = rand(min..max)
        @flashcard = Flashcard.find_or_next(id)
    end

    def self.find_or_next(id)
        card = where('id >= ?', id).limit(1).first
        raise ActiveRecord::RecordNotFound if card.nil?
        
        card
    end
end
