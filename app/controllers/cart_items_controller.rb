class CartItemsController < ApplicationController
  include SetCart
  before_action :find_cart_items, only: [ :edit, :update, :destroy ]

  def create
    product = Product.find(params[:product_id])
    cart_item = @cart.cart_items.find_or_initialize_by(product: product)
    if product.stock_quantity > 0
      cart_item.quantity = cart_item.quantity.to_i + 1
      if cart_item.save
        flash[:notice] = 'Product added to cart.'
      else
        flash[:alert] = 'Product could not be added.'
      end
    else
      flash[:notice] = 'Stock is Insufficient.'
    end
    redirect_to cart_path
  end

  def edit
  end

  def update
    if @cart_item.update(quantity: params[:cart_item][:quantity])
      flash[:notice] = 'Cart Updated.'
    else
      flash[:notice] = 'Could not update cart.'
    end
    redirect_to cart_path
  end

  def destroy
    @cart_item.destroy
    flash[:notice] = 'Item removed from cart.'
    redirect_to cart_path
  end

  private

  def find_cart_items
    @cart_item = @cart.cart_items.find(params[:id])
  end
end
