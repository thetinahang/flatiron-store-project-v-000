module ApplicationHelper
  def current_cart
    Cart.find(current_user.current_cart_id)
  end 
end
