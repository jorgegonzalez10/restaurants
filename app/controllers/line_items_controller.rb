class LineItemsController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: [:create]

  def show
  end

  def create
    product = Product.find(params[:product_id])
    @line_item = @cart.add_product(product)
    @line_item.save
  end

  def new
  end

  def destroy
  end
end
