class ItemsController < ApplicationController

  def index
    @items = Item.all
  end

  def show
    @item = Item.find_by_id(params[:id])
  end

  def create
    @item = Item.create(item_params)
  end

  private

  def item_params
    params[:item].permit(:title, :inventory, :price, :category_id)
  end
  
end
