class ItemsController < ApplicationController
  before_action :select_item, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show, :destroy]
  before_action :move_to_index, only: [:edit, :update]
  before_action :move_to_index_soldout, only: [:edit]
  
  def index
    @items = Item.all.order(created_at: :desc)
  end  

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @items = Item.all.order(created_at: :desc)
  end

  def edit
  end

  def update
    if  @item.update(item_params)
      redirect_to item_path
    else
      render action: :edit
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end

  private
  def item_params
    params.require(:item)
    .permit(:product, :product_description, :category_id, :condition_id, :postage_id, :prefecture_id, :shipping_date_id, :price, :image)
    .merge(user_id: current_user.id)
  end

  def select_item
    @item = Item.find(params[:id])
  end

  def move_to_index 
    unless current_user.id == @item.user.id
    redirect_to action: :index
    end
  end

  def move_to_index_soldout
    if @item.order != nil
      redirect_to action: :index
    end
  end

end
