class Manager::DashboardController < ApplicationController
  before_action :check_manager

  def index
    @total_sales = Order.where(status: 'delivered').sum(:total)
    @orders_by_status = Order.group(:status).count
    @best_selling_products = OrderItem
      .joins(:product, :order)
      .where(orders: { status: 'delivered' })
      .group('products.name')
      .order('SUM(quantity) DESC')
      .sum(:quantity)
  end

  private

  def check_manager
    redirect_to root_path unless current_user.manager?
  end
end
