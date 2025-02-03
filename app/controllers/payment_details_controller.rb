class PaymentDetailsController < ApplicationController
  def new
    @payment_detail = PaymentDetail.new(user: current_user)
  end

  def create
    @payment_detail = current_user.build_payment_detail(payment_detail_params)
    if @payment_detail.save
       redirect_to cart_path, notice: "Payment details added successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def payment_detail_params
    params.require(:payment_detail).permit(:card_number, :expiry_date, :cvv)
  end
end
