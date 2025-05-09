class Order < ApplicationRecord
  has_many :products, optional: true
  has_many :line_items
end
