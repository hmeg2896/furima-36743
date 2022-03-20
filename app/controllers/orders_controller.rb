class OrdersController < ApplicationController
  def index
    @order_item = Item.find(params[:item_id])
    @purchase_address = PurchaseAddress.new
    
  end

  def create
    @purchase_address = PurchaseAddress.new(purchase_address_params)
    #binding.pry
    if @purchase_address.valid?
      @purchase_address.save
      redirect_to root_path
    else
      @order_item = Item.find(params[:item_id])
      render :index
    end
  end

  private 
  def purchase_address_params
    params.require(:purchase_address).permit(:postal_code, :prefecture_id, :city, :address, :building_name, :phone_number).merge(item_id: params[:item_id], user_id: current_user.id)
  end
  
end

