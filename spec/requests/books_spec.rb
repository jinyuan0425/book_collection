# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Books', type: :request do
  describe 'POST /books' do
    context 'when the request is valid (sunny-day scenario)' do
      it 'creates a new book with all attributes and shows a success flash notice' do
        post books_path,
             params: { book: { title: 'New Book', author: 'John Doe', price: 25.99, published_date: '2025-01-01' } }

        expect(response).to redirect_to(books_path)
        follow_redirect!

        expect(response.body).to include('Book was successfully created.')

        created_book = Book.last
        expect(created_book.title).to eq('New Book')
        expect(created_book.author).to eq('John Doe')
        expect(created_book.price).to eq(25.99)
        expect(created_book.published_date).to eq(Date.parse('2025-01-01'))
      end
    end

    context 'when the request is invalid (rainy-day scenario)' do
      it 'does not add the book and shows an error flash notice' do
        post books_path,
             params: { book: { title: '', author: 'John Doe', price: 25.99, published_date: '2025-01-01' } }

        expect(response).to render_template(:new)

        expect(response.body).to include('There was an error creating the book.')

        expect(Book.count).to eq(0)
      end

      it 'does not create a book without an author and shows an error flash notice' do
        post books_path,
             params: { book: { title: 'New Book', author: nil, price: 25.99, published_date: '2025-01-01' } }

        expect(response).to render_template(:new)

        expect(response.body).to include('There was an error creating the book.')

        expect(Book.count).to eq(0)
      end

      it 'does not create a book without a price and shows an error flash notice' do
        post books_path,
             params: { book: { title: 'New Book', author: 'John Doe', price: nil, published_date: '2025-01-01' } }

        expect(response).to render_template(:new)

        expect(response.body).to include('There was an error creating the book.')

        expect(Book.count).to eq(0)
      end

      it 'does not create a book with a non-numeric price and shows an error flash notice' do
        post books_path,
             params: { book: { title: 'New Book', author: 'John Doe', price: 'abc',
                               published_date: '2025-01-01' } }

        expect(response).to render_template(:new)

        expect(response.body).to include('There was an error creating the book.')

        expect(Book.count).to eq(0)
      end

      it 'does not create a book without a published_date and shows an error flash notice' do
        post books_path,
             params: { book: { title: 'New Book', author: 'John Doe', price: 25.99, published_date: nil } }

        expect(response).to render_template(:new)

        expect(response.body).to include('There was an error creating the book.')

        expect(Book.count).to eq(0)
      end
    end
  end
end
