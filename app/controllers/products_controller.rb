class ProductsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    @categories = Category.order(name: :asc)
    if params[:query].present?
      @products = Product.search_products_by_name_price_or_discount(params[:query])
    else
      @products = Product.ordered
    end
      @pagy, @products = pagy(@products, items: 20)
    if params[:category_id]
       @products = @products.where(category_id: params[:category_id])
       @products_best = Product.where(discount: 20..40).limit(8)
    end
  end

  def show
    @product = Product.find(params[:id])
    @review = Review.new
    @pagy, @reviews = pagy(@product.reviews.order(created_at: :desc), items: 4,)
    @average_rating = @product.reviews.average(:rating)&.round(2) || 0
    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end
end
