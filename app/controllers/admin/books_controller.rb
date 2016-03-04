class Admin::BooksController < Admin::AdminsController
  before_action :authenticate_user!
  expose(:books)
  expose(:book)

  def index
  end

  def destroy
    book.destroy
    redirect_via_turbolinks_to admin_books_path
  end
end
