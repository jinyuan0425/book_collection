require 'rails_helper'

RSpec.describe "Books", type: :request do
  describe "POST /books" do
    context "when the request is invalid (rainy-day scenario)" do
      it "does not add the book and shows an error flash notice" do
        post books_path, params: { book: { title: "" } }

        expect(response).to have_http_status(:ok)

        expect(flash[:alert]).to eq("There was an error creating the book.")

        expect(response.body).to include("There was an error creating the book.")

        expect(Book.count).to eq(0)
      end
    end
  end
end
