class ProductsController < ApplicationController

  def index
    if params[:query].present?
      @products = Product.includes(:reviews).search_products_by_name_price_or_discount(params[:query])
    else
      @products = Product.ordered.includes(:reviews)
    end
  end

  def show
    @product = Product.find(params[:id])
    @review = Review.new
    @pagy, @reviews = pagy(@product.reviews.order(created_at: :desc))
    @average_rating = @product.reviews.average(:rating)&.round(2) || 0
    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end
end
