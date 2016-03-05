class BooksController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token, only: :create
  before_action :book, only: :new
  before_action :books, only: :index

  def index
  end

  def new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_via_turbolinks_to books_path
    end
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
      :author,
      category_ids: []
    )
  end

  def book
    @book ||= books.find_by(id: params[:id]) || Book.new
  end

  def books
    @books ||= current_user.books
  end
end
