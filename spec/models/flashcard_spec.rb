require 'rails_helper'

RSpec.describe Flashcard, type: :model do
  context 'Validations' do
    it { should validate_presence_of :question }
    it { should validate_presence_of :answer }
  end
end
