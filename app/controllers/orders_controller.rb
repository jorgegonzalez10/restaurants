class OrdersController < ApplicationController
  before_action :set_order, only: %i[edit show destroy payment]
  before_action :set_service, only: %i[payment index]

  def show
  end

  def create
    # @order = Order.new(date: Date.today)
    # @order.user = current_user
    # @order.save
    @order = current_user.orders.build(date: Date.today)
    @order.save

    @order.switch_items(session[:cart_id], @order.id)
    #@line_items = LineItem.where(cart_id: session[:cart_id])
    # @line_items.each do |item|
    #   item.order_id = @order.id
    #   item.save

    # cart = Cart.find(session[:cart_id])
    #cart.destroy
    #session[:cart_id] = nil
    redirect_to order_path(@order)
  end

  def payment
    redirect_to set_service.call, allow_other_host: true
  end

  def index
    set_service.index
    flash[:notice] = "¡Thanks for shopping!"
    @orders = current_user.orders.where(paid: true).order(created_at: :desc)
  end

  def edit
  end

  def destroy
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  def set_service
    PaymentService.new(@order, params, current_user)
  end
end
