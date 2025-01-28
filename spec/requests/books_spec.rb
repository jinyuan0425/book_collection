require 'rails_helper'

RSpec.describe "Books", type: :request do
  describe "POST /books" do
    context "when the request is valid (sunny-day scenario)" do
      it "adds the book and shows a success flash notice" do
        post books_path, params: { book: { title: "New Book" } }

        expect(response).to redirect_to(books_path)
        follow_redirect!

        expect(response.body).to include("Book was successfully created.")

        expect(Book.last.title).to eq("New Book")
      end
    end

    context "when the request is invalid (rainy-day scenario)" do
      it "does not add the book and shows an error flash notice" do
        post books_path, params: { book: { title: "" } }

        expect(response).to render_template(:new)

        expect(response.body).to include("There was an error creating the book.")

        expect(Book.count).to eq(0)
      end
    end
  end
end
