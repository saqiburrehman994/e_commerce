class OrderItemsController < ApplicationController
  def index
    @order = current_user.orders.find(params[:id])
    @order_items = @order.order_items.includes(:product)
  end
end
