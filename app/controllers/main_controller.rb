class MainController < ApplicationController
  authorize_resource :class => false

  def index
    @book = Book.all
  end

end