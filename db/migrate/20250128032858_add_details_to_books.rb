# frozen_string_literal: true

class AddDetailsToBooks < ActiveRecord::Migration[6.1]
  def change
    add_column :books, :author, :string
    add_column :books, :price, :decimal
    add_column :books, :published_date, :date
  end
end
