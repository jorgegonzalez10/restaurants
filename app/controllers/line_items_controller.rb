class LineItemsController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: [:create]

  def show

  end

  def create
    product = Product.find(params[:product_id])
    @line_item = @cart.add_product(product)
    @line_item.save

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to products_path, notice: 'Added to cart.' }
    end
  end

  def new
  end

  

  def destroy
    @line_item = LineItem.find(params[:id])

      @line_item.destroy
      redirect_to carts_show_path(session[:cart_id]), notice: 'Product has been deleted.'

  end
end
