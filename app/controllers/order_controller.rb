class OrderController < ApplicationController

    before_action :define_order, only: [:show]

    ##############   I N D E X   and   S H O W

    ## GET
    def index

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

    private

    def define_order

      @order = Order.find(params[:id])

    end

    def params_order

      # params.require(:order).permit(:title)

    end
end
