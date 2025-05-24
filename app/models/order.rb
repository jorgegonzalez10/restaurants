# == Schema Information
#
# Table name: orders
#
#  id                  :bigint           not null, primary key
#  date                :date
#  name                :string
#  address             :string
#  total               :float
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  checkout_session_id :string
#  paid                :boolean          default(FALSE)
#  user_id             :bigint           not null
#
class Order < ApplicationRecord
  has_many :products
  has_many :line_items, dependent: :destroy
  belongs_to :user

  def switch_items(cart_id, order_id)

    LineItem.where(cart_id: cart_id).each do |item|
      item.order_id = order_id
      item.save
      end
  end
end
