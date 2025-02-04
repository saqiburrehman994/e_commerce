class OrderMailer < ApplicationMailer
  def new_order_email
    @order = params[:order]
    mail(to: @order.user.email, subject: "Order_Confirmation")
  end

  def status_order_email
    @order = params[:order]
    mail(to: @order.user.email, subject: "Order Status Update")
  end
end
