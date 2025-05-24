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
require "test_helper"

class OrderTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
