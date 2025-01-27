require 'rails_helper'

RSpec.describe Book, type: :model do
  let(:valid_book) { Book.new(title: 'Valid Title') }
  let(:invalid_book) { Book.new(title: nil) }

  context 'validations' do
    it 'is valid with a title' do
      expect(valid_book).to be_valid
    end

    it 'is invalid without a title' do
      expect(invalid_book).not_to be_valid
      expect(invalid_book.errors[:title]).to include("can't be blank")
    end
  end
end
