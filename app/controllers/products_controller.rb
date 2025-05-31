class ProductsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    result = ProductService.new(params).call
    @products = result[:products].order(Product::ORDER_BY.fetch(params[:order_by], "created_at DESC"))
    @categories = result[:categories]
    @selected_category = result[:selected_category]
    @pagy, @products = pagy(@products, items: 20)
  end

  def show
    @product = Product.find(params[:id])
    @review = Review.new
    @pagy, @reviews = pagy(@product.reviews.order(created_at: :desc), items: 4)
    @average_rating = @product.reviews.average(:rating)&.round(2) || 0
    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end
end
