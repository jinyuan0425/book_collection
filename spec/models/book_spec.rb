# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Book, type: :model do
  let(:valid_book) { Book.new(title: 'Valid Title') }
  let(:invalid_book) { Book.new(title: nil) }

  context 'validations' do
    it 'is valid with a title, author, price, and published_date' do
      book = Book.new(
        title: 'Valid Title',
        author: 'Valid Author',
        price: 19.99,
        published_date: Date.today
      )
      expect(book).to be_valid
    end

    it 'is invalid without a title' do
      book = Book.new(
        title: nil,
        author: 'Valid Author',
        price: 19.99,
        published_date: Date.today
      )
      expect(book).not_to be_valid
      expect(book.errors[:title]).to include("can't be blank")
    end

    it 'is invalid without an author' do
      book = Book.new(
        title: 'Valid Title',
        author: nil,
        price: 19.99,
        published_date: Date.today
      )
      expect(book).not_to be_valid
      expect(book.errors[:author]).to include("can't be blank")
    end

    it 'is invalid without a price' do
      book = Book.new(
        title: 'Valid Title',
        author: 'Valid Author',
        price: nil,
        published_date: Date.today
      )
      expect(book).not_to be_valid
      expect(book.errors[:price]).to include("can't be blank")
    end

    it 'is invalid with a non-numeric price' do
      book = Book.new(
        title: 'Valid Title',
        author: 'Valid Author',
        price: 'abc',
        published_date: Date.today
      )
      expect(book).not_to be_valid
      expect(book.errors[:price]).to include('is not a number')
    end

    it 'is invalid without a published_date' do
      book = Book.new(
        title: 'Valid Title',
        author: 'Valid Author',
        price: 19.99,
        published_date: nil
      )
      expect(book).not_to be_valid
      expect(book.errors[:published_date]).to include("can't be blank")
    end
  end
end
