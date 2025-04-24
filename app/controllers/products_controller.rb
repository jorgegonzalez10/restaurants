class ProductsController < ApplicationController

  def index
    @products = Product.ordered
  end

  def show
    @product = Product.find(params[:id])
  end
end
