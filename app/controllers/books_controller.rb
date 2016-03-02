class BooksController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token, only: [:create]
  def index
    @books = Book.all
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      redirect_via_turbolinks_to books_path
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_via_turbolinks_to books_path
  end

  private

  def book_params
    params.require(:book).permit(
      :title,
      :attachment,
      :thumbnail,
      :description,
      :pages,
      :year,
      :author
    )
  end
end
