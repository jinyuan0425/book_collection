class Book < ApplicationRecord
    validates :title, :author, :published_date, presence: true
    validates :price, presence: true, numericality: true
  end
  