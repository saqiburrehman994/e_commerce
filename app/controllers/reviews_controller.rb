class ReviewsController < ApplicationController
  before_action :find_product
  before_action :enusure_purchased!, only: [:new,:create]

  def new
    @review = @product.reviews.new
  end
  def create
      @review = @product.reviews.new(review_params)
      @review.user = current_user
      if @review.save
        respond_to do |format|
          format.turbo_stream
        end
      else
        flash[:alert] = "Failed to add review."
        redirect_to product_path(@product)
      end
  end

  def edit
    @review = current_user.reviews.find(params[:id])
  end

  def update
    @review = current_user.reviews.find(params[:id])
    if @review.update(review_params)
      respond_to do |format|
        format.turbo_stream
      end
    else
      flash[:alert] = "Failed to update review."
      redirect_to product_path(@product)
    end
  end

  def destroy
    @review = @product.reviews.find(params[:id])
    @review.destroy
    redirect_to product_path(@product), notice: "Review deleted successfully."
  end

  private

  def find_product
    @product = Product.find(params[:product_id])
  end

  def enusure_purchased!
    unless current_user.purchased?(@product)
      redirect_to product_path(@product), alert: "You can only add reviews if you have purchased this product."
    end
  end

  def review_params
    params.require(:review).permit(:rating,:comment)
  end

end
