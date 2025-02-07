# frozen_string_literal: true

class Book < ApplicationRecord
  has_many :users, through: :user_books
  has_many :user_books

  validates :title, :author, :published_date, presence: true
  validates :price, presence: true, numericality: true
end
