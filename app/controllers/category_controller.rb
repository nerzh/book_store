class CategoryController < ApplicationController
  load_and_authorize_resource

  def index
    @books = Book.all.page params[:page]
    @categories = Category.all
  end

  def show
    @books = @category.books.page params[:page]
    @categories = Category.all
  end

  private

  def params_category
    params.require(:category).permit(:title)
  end

end
