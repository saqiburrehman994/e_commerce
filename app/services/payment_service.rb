class PaymentService
  def initialize(order,card_details)
    @order = order
    @card_details = card_details
  end

  def process_payment
    success = [true]*9 + [false]*1
    success = success.sample
    if success
      @order.update(status: "processing", payment_status: "paid")
      return { success: true, message: "Payment successful!" }
    else
      return { success: false, message: "Payment failed! Please try again."}
    end
  end
end
