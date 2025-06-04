class ProductsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    service = ProductService.new(params).call
    @products = service[:products].order(Product::ORDER_BY.fetch(params[:order_by], "created_at DESC"))
    @categories = service[:categories]
    @selected_category = service[:selected_category]
    @pagy, @products = pagy(@products, items: 20)
  end

  def show
    service = ProductService.new(params).show(params[:id], self)

    @product = service.product
    @review = service.review
    @reviews = service.reviews
    @average_rating = service.average_rating
    @pagy, @reviews = pagy(@product.reviews.order(created_at: :desc), items: 4)
    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end
end
