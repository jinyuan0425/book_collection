class BooksController < ApplicationController
  def index
    @books = Book.order(:title)
  end

  def show
    @book = Book.find(params[:id])
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      redirect_to(books_path, notice: 'Book was successfully created.')
    else
      flash[:alert] = "There was an error creating the book."
      render('new')
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to(book_path(@book), notice: 'Book was successfully updated.')
    else
      flash[:alert] = "There was an error updating the book."
      render('edit')
    end
  end

  def delete
    @book = Book.find(params[:id])
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to(books_path, notice: 'Book was successfully deleted.')
  end

  def book_params
    params.require(:book).permit(:title, :author, :price, :published_date)
  end
end
