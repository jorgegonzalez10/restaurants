class PagesController < ApplicationController
  def home
    if params[:query].present?
      @products = Product.includes(:reviews).search_products_by_name_price_or_discount(params[:query])
    else
    @products = Product.ordered.includes(:reviews).where(discount: 20..40).limit(8)
    end
  end
end
