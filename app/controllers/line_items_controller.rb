class LineItemsController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: [:create]

  def show

  end

  def create
    product = Product.find(params[:product_id])
    @line_item = @cart.add_product(product)
    if @line_item.save

      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to products_path, notice: 'Added to cart.' }
      end
    end
  end

  def new
  end

  def increment
    @cart = Cart.find session[:cart_id]
    @line_item = LineItem.find(params[:id])
    @line_item.increment!(:quantity)
    if @line_item.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to cart_path(@line_item.cart) }
      end
    end
  end

  def decrement
    @cart = Cart.find session[:cart_id]
    @line_item = LineItem.find(params[:id])
    if @line_item.quantity > 1
      @line_item.decrement!(:quantity)
    else
      @line_item.destroy
    end
    if @line_item.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to cart_path(@line_item.cart) }
      end
    end
  end

  def destroy
    @line_item = LineItem.find(params[:id])

      @line_item.destroy
      redirect_to cart_path(session[:cart_id]), notice: 'Product has been deleted.'

  end
end
