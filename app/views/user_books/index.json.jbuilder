# frozen_string_literal: true

json.array! @user_books, partial: 'user_books/user_book', as: :user_book
