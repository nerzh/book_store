class BookController < ApplicationController

  before_action :define_book, only: [:show]

  def index
    @books = Book.all.page params[:page]
  end

  private

  def define_book
    @book = Book.find(params[:id])
  end

  def params_book
    params.require(:book).permit(:title, :price, :authors)
  end

end
