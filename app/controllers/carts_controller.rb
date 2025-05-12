class CartsController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: [:show, :add]
  def show
  end

  def add
    @line_item = @cart.line_item
    @line_item.quantity += 1
  end

end
