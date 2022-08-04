class MerchantDiscountsController < ApplicationController 

    def index 
        @merchant = Merchant.find(params[:merchant_id])
    end 

    def show 
        @discount = Discount.find(params[:id])
        @merchant = Merchant.find(params[:merchant_id])
    end 

    def new 
        @merchant = Merchant.find(params[:merchant_id])
    end 

    def create
        merchant = Merchant.find(params[:merchant_id])
        discount = merchant.discounts.new(percent: params[:percent], quantity_threshold: params[:quantity_threshold])
        if discount.save
          redirect_to "/merchants/#{merchant.id}/discounts"
        else
          redirect_to "/merchants/#{merchant.id}/discounts/new"
          flash[:alert] = "Error: Please fill out all required fields!"
        end
    end 

    def destroy
        Discount.find(params[:id]).destroy 
        redirect_to "/merchants/#{params[:merchant_id]}/discounts"
    end 

    def edit 
        @discount = Discount.find(params[:id])
    end 

    # private 
    # def merchant_params 
    #     params.require(:discount).permit(:percent, :quantity_threshold)
    # end
end 