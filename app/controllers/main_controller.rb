class MainController < ApplicationController

  authorize_resource :class => false

  ##############   I N D E X   and   S H O W

  ## GET
  def index
    @book = Book.all
  end

  ## GET
  def show

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

end