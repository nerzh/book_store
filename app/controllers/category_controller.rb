class CategoryController < ApplicationController

  before_action :define_category, only: [:show]
  authorize_resource

  def index
    @books = Book.all.page params[:page]
    @categories = Category.all
  end

  def show
    @books = @category.books.page params[:page]
    @categories = Category.all
  end

  private

  def define_category
    @category = Category.find(params[:id])
  end

  def params_category
    params.require(:category).permit(:title)
  end

end
