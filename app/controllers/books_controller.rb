class BooksController < ApplicationController
  def index
    @books = Book.all
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      redirect_to books_path, notice: "The book #{@book.title} has been uploaded."
    else
      render "new"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path, notice:  "The book #{@book.title} has been deleted."
  end

  private

  def book_params
    params.require(:book).permit(:title, :attachment)
  end
end
