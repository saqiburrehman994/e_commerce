class OrdersController < ApplicationController

  def index
    @orders = current_user.orders.order(created_at: :desc)
  end

  def show
    @order = current_user.orders.find(params[:id])
  end

  def checkout
      cart = current_user.cart
      return redirect_to cart_path, alert: "Your cart is empty!" if cart.cart_items.empty?
      order = Order.create(user: current_user, status: "pending" , total:0 )
      cart.cart_items.each do |cart_item|
        order.order_items.create(
          product: cart_item.product,
          quantity: cart_item.quantity,
          price_at_purchase: cart_item.product.price
        )
      end
      order.update(total: order.order_items.sum {|item| item.quantity * item.price_at_purchase})
      cart.cart_items.destroy_all
      flash[:notice] = "Order placed successfully."
      redirect_to order_path(order)
  end
end
