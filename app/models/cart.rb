# == Schema Information
#
# Table name: carts
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Cart < ApplicationRecord
  has_many :products
  has_many :line_items

  def add_product(product)
    current_item = line_items.find_by(product_id: product.id)
    if current_item
      current_item.quantity = (current_item.quantity || 0) + 1
    else
      current_item = line_items.build(product_id: product.id, price: product.price, quantity: 1)
    end
    current_item
  end

  def total_price
    line_items.sum do |item|
      item.price * item.quantity
    end
  end
end
