class CartsController < ApplicationController
  include SetCart

  def show
    @cart_items = @cart.cart_items.includes(:product)
  end
end
