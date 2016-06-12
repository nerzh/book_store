class BookController < ApplicationController
  load_resource

  def index
    @books = Book.all.page params[:page]
  end

  private

  def params_book
    params.require(:book).permit(:title, :price, :authors)
  end

end
