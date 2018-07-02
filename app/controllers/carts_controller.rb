class CartsController < ApplicationController

  def index
    @cart = Cart.find_by_id(params[:id])
  end

  def new
    @cart = Cart.new(params[:user_id])
  end

  def create
    @cart = Cart.create(params[:user_id])
  end

  def show
    @cart = Cart.find_by_id(current_user.current_cart_id)
    current_user.save
  end

  def checkout
    @cart = Cart.find(params[:id])
    @cart.line_items.each do |li|
      li.item.inventory -= li.quantity
      li.item.save
    end
    @cart.status = "submitted"
    current_user.current_cart.save
    current_user.current_cart = nil
    redirect_to cart_path(@cart), notice: "Order placed."
  end

end
