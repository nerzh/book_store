class CategoryController < ApplicationController

  before_action :define_category, only: [:show]
  authorize_resource

  ##############   I N D E X   and   S H O W

  ## GET
  def index

    @books = Book.all.page params[:page]
    @categories = Category.all

  end

  ## GET
  def show

    @books = @category.books.page params[:page]
    @categories = Category.all

  end

  ##############   C R E A T E

  ## GET
  def new

  end

  ## POST
  def create

  end

  ##############   U P D A T E

  ## GET
  def edit

  end

  ## PATCH
  def update

  end

  ##############   D E L E T E

  ## DELETE
  def delete

  end

  ## DELETE
  def destroy

  end

  ##############   M Y   M E T H O D S

  private

  def define_category

    @category = Category.find(params[:id])

  end

  def params_category

    params.require(:category).permit(:title)

  end
end
