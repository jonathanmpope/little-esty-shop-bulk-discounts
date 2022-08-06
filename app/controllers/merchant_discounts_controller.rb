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
        # binding.pry 
        if params[:percent].to_i == 0 || params[:percent].to_i > 99
            redirect_to "/merchants/#{merchant.id}/discounts/new"
            flash[:alert] = "Error: Discount percent can't be 0 or above 99!"
        elsif discount.save
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
        @merchant = Merchant.find(params[:merchant_id])
        @discount = Discount.find(params[:id])
    end 

    def update 
        discount = Discount.find(params[:id])
        discount.update(discount_params)
        redirect_to "/merchants/#{params[:merchant_id]}/discounts/#{params[:id]}"
    end 

    private 
    def discount_params 
        params.require(:discount).permit(:percent, :quantity_threshold)
    end
end 