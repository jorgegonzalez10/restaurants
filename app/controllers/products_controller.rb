class ProductsController < ApplicationController

  def index
    if params[:query].present?
      @products = Product.search_products_by_name_price_or_discount(params[:query])
    else
    @products = Product.ordered
    end
  end

  def show
    @product = Product.find(params[:id])
  end
end
