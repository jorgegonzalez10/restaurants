class PaymentService

  def initialize(order, params, current_user)
    @order = order
    @params = params
    @current_user = current_user
  end

  def call
    total_amount = (@order.line_items.sum { |item| item.price * item.quantity }).to_i
    @order.update(total: total_amount, name: @params[:order][:name], address: @params[:order][:address], user_id: @current_user.id )
    session = Stripe::Checkout::Session.create(
    payment_method_types: ['card'],
    line_items: @order.line_items.map do |item|
      {
        price_data: {
          currency: 'usd',
          unit_amount: (item.price * 100).to_i,
          product_data: {
            name: item.product.name
          }
        },
        quantity: item.quantity
      }
    end,
    mode: 'payment',
    success_url: Rails.application.routes.url_helpers.orders_url(host: "localhost:3000") + "?order_id=#{@order.id}",
    cancel_url: Rails.application.routes.url_helpers.order_url(@order, host: "localhost:3000")
  )

  @order.update(checkout_session_id: session.id)
  session.url
  end

  def index
    if @params[:order_id].present?
    order = Order.find(@params[:order_id])
      unless order.paid?
        order.update(paid: true)
        order.line_items.destroy_all
      end
    end
  end
end
