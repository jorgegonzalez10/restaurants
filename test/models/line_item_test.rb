# == Schema Information
#
# Table name: line_items
#
#  id         :bigint           not null, primary key
#  product_id :bigint           not null
#  cart_id    :bigint
#  order_id   :bigint
#  quantity   :integer
#  price      :float
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require "test_helper"

class LineItemTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
