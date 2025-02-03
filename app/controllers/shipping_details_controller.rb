class ShippingDetailsController < ApplicationController
  def new
    @shipping_detail = ShippingDetail.new(user: current_user)
  end

  def create
    @shipping_detail = current_user.build_shipping_detail(shipping_detail_params)
    if @shipping_detail.save
      redirect_to cart_path, notice: "Shipping details added successfully.Now you can proceed to checkout."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @shipping_detail = current_user.shipping_detail
  end

  def update
    @shipping_detail = current_user.shipping_detail
    if @shipping_detail.update(shipping_detail_params)
      redirect_to cart_path, notice: "Shipping details updated successfully.Now you can proceed to checkout."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def shipping_detail_params
    params.require(:shipping_detail).permit(:name, :address, :phone_number)
  end
end
