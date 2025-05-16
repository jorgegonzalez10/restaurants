class OrdersController < ApplicationController
  before_action :set_order, only: %i[edit show destroy]
  def show
  end

  def create
    @order = Order.create(date: Date.today)
    @line_items = LineItem.where(cart_id: session[:cart_id])
    @line_items.each do |item|
      item.order_id = @order.id
      item.save
    end
    cart = Cart.find(session[:cart_id])
    #cart.destroy
    #session[:cart_id] = nil
    redirect_to order_path(@order)
  end

  def edit
  end

  def destroy
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end
end
