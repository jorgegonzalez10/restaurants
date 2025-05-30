class ProductsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @categories = Category.order(name: :asc)
    @selected_category = Category.find_by(id: params[:category_id]) if params[:category_id].present?
    @products = if params[:query].present?
                  Product.search_products_by_name_price_or_discount(params[:query])
                else
                  Product.all
                end
    @products = @products.where(category_id: params[:category_id]) if params[:category_id].present?
    @products = @products.where("price >= ?", params[:min_price]) if params[:min_price].present?
    @products = @products.where("price <= ?", params[:max_price]) if params[:max_price].present?

    order_by = Product::ORDER_BY.fetch(params[:order_by], "created_at DESC")

    @products = @products.order(order_by)

    @pagy, @products = pagy(@products, items: 20)
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
