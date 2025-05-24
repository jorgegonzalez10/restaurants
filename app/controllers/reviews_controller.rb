class ReviewsController < ApplicationController
  def new
  end

  def show
  end

  def create
    @product = Product.find(params[:product_id])
    @review = Review.new(review_params)
    @review.product = @product
    @review.user = current_user
    if @review.save
      redirect_to product_path(@product)
    else
      @reviews = @product.reviews
      @average_rating = @product.reviews.average(:rating)&.round(2) || 0
      render 'products/show', status: :unprocessable_entity
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to product_path(@review.product), notice: "Review deleted." }
  end
end

  private

  def review_params
    params.require(:review).permit(:rating, :content)
  end
end
