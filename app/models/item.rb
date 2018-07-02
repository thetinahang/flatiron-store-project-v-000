class Item < ActiveRecord::Base
  belongs_to :cart
  belongs_to :user
  belongs_to :category
  has_many :line_items

  def self.available_items
    @available_items = []
    self.all.each do |item|
      if item.inventory != 0
        @available_items << item
      end
    end
    @available_items
  end
end
