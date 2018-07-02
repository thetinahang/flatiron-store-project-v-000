class Cart < ActiveRecord::Base
  has_many :items, through: :line_items
  has_many :line_items
  belongs_to :user


  def check_out
    self.line_items.each do |line_item|
      item = Item.find(line_item.item_id)
      item.inventory = item.inventory - line_item.quantity
      item.save
    end
    # binding.pry
    user.update(current_cart: nil)
    self.update(status: "submitted")
  end

  def total
    @items_total = []
    self.line_items.each do |item|
      @item = Item.find_by_id(item.item_id)
      @items_total << @item.price.to_f
    end
    cart_total = @items_total.inject(0){|sum, x| sum + x }
    @cart_total = cart_total.round(2)
    @cart_total
  end

  def add_item(next_item)
    @current_line_item = self.line_items.find_by_id(next_item)
    if @current_line_item
      @current_line_item.quantity += 1
      @current_line_item.save
    else
      @current_line_item = self.line_items.build(item_id: next_item)
    end
    @current_line_item
  end

end
