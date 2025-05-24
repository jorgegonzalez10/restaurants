class Users::ProductsController < ApplicationController
  before_action :set_product, only: %i[show edit update destroy]

  def index
    if params[:query].present?
      @products = Product.includes(:reviews).search_products_by_name_price_or_discount(params[:query])
    else
    @products = Product.includes(:reviews).ordered
    end
  end

  def cards
    if params[:query].present?
      @products = Product.includes(:reviews).search_products_by_name_price_or_discount(params[:query])
    else
      @products = Product.includes(:reviews).ordered
    end
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
      respond_to do |format|
       format.html { redirect_to users_products_url, notice: "Product was successfully created." }
       format.turbo_stream
      end
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
    params.require(:product).permit(:name, :description, :price, :stock, :photo, :discount, :review, :category_id)
  end
end
