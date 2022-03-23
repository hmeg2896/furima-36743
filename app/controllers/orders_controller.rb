class OrdersController < ApplicationController
  before_action :select_item, only: [:index, :create]
  before_action :authenticate_user!
  before_action :move_to_index, only: [:index]
  before_action :move_to_index_soldout, only: [:index]


  def index
    @purchase_address = PurchaseAddress.new
  end

  def create
    @purchase_address = PurchaseAddress.new(purchase_address_params)

    if @purchase_address.valid?
      pay_item
      @purchase_address.save
      redirect_to root_path
    else
      render :index
    end
  end





  private 
  def purchase_address_params
    params.require(:purchase_address).permit(:postal_code, :prefecture_id, :city, :address, :building_name, :phone_number).merge(item_id: params[:item_id], user_id: current_user.id, token: params[:token])
  end
  
  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"] 
    Payjp::Charge.create(
    amount:@order_item.price,  
    card: purchase_address_params[:token],    
    currency: 'jpy'                
      )
  end
  
  def select_item
    @order_item = Item.find(params[:item_id])
  end

  def move_to_index 
    if current_user.id == @order_item.user.id
    redirect_to root_path
    end
  end

  def move_to_index_soldout
    if @order_item.order != nil
      redirect_to root_path
    end
  end
    
  
end

