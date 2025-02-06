class OrdersController < ApplicationController
  def index
    @orders = current_user.orders.order(created_at: :desc)
  end

  def manage
    if can? :manage, Order
      @orders = Order.order(created_at: :desc)
    else
      head :forbidden
      flash[:alert] = "You are not authorized to manage orders."
    end
  end

  def update_status
    @order = Order.find(params[:id])
    if can? :update_status, @order
        if @order.update(status: params[:status])
          flash[:notice] = "Order status updated successfully."
          OrderMailer.with(order: @order).status_order_email.deliver_now
        else
          flash[:alert] = "Failed to update order status."
        end
    else
        flash[:alert] = "You are not authorized to perform this task."
        redirect_to manage_orders_path and return
    end
    redirect_to manage_orders_path
  end

  def show
    @order = current_user.orders.find(params[:id])
  end

  def checkout
    cart = current_user.cart
    return redirect_to cart_path, alert: "Your cart is empty!" if cart.cart_items.empty?

    unless current_user.shipping_detail
      return redirect_to new_shipping_detail_path, alert: "Please enter your shipping details before checkout."
    end

    unless current_user.payment_detail
      return redirect_to new_payment_detail_path, alert: "Please enter your payment details before checkout."
    end

    cart.cart_items.each do |cart_item|
      if cart_item.product.stock_quantity < cart_item.quantity
        return redirect_to cart_path, alert: "Stock is insufficient for #{cart_item.product.name}."
      end
    end

    order = Order.create(user: current_user, status: "pending", total: 0, payment_status: "unpaid")

    cart.cart_items.each do |cart_item|
      product = cart_item.product
      order.order_items.create(
        product: product,
        quantity: cart_item.quantity,
        price_at_purchase: product.price
      )
      product.decrement!(:stock_quantity, cart_item.quantity)
    end

    order.update(total: order.order_items.sum { |item| item.quantity * item.price_at_purchase })
    payment_service = PaymentService.new(order, params[:card_details])
    payment_result = payment_service.process_payment
    if payment_result[:success]
      cart.cart_items.destroy_all
      flash[:notice] = "Order placed successfully.#{payment_result[:message]}"
      OrderMailer.with(order: order).new_order_email.deliver_now
      current_user.payment_detail.destroy
      redirect_to order_path(order)
    else
      order.order_items.each do |order_item|
        order_item.product.increment!(:stock_quantity, order_item.quantity)
      end
      order.update(status: "cancelled")
      flash[:alert] = payment_result[:message]
      redirect_to cart_path
    end
  end
end
