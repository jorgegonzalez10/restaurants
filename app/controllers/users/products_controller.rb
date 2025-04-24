class Users::ProductsController < ApplicationController
  before_action :set_product, only: %i[ show edit update destroy ]

  def index
    @products = Product.ordered
  end

  def cards
    @products = Product.ordered
  end

  def show
  end

  def edit
  end

  def create
    #@product = Product.new(product_params)
    #@product.user = current_user
    @product = current_user.products.build(product_params)
    if @product.save

     redirect_to users_products_url, notice: "Product was successfully created."

    else
      render :new, status: :unprocessable_entity
    end
  end

  def new
    @product = Product.new
  end

  def destroy
    @product.destroy

    redirect_to users_products_url, notice: "Product was successfully destroyed.", status: :see_other
  end

  def update
    if @product.update(product_params)
      redirect_to users_products_url, notice: "Product was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private
  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :description, :price, :stock, :photo)
  end
end
