class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :carts

#  def current_cart
#    self.current_cart_id = current_cart_id
#  end
#  def checkout
#    current_user.current_cart = nil
#  end

  def create_current_cart
    new_cart = carts.create
    self.current_cart_id = new_cart.id
    save
    new_cart
  end

  def remove_cart
    self.current_cart_id = nil
    save
  end

  def current_cart
    if current_cart_id.nil?
      nil
    else
      Cart.find(current_cart_id)
    end
  end

  def current_cart=(cart)
    if cart.nil?
      self.current_cart_id = nil
    else
      self.current_cart_id = cart.id
    end
    self.save
  end
end
