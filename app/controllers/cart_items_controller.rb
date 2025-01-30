class CartItemsController < ApplicationController
  before_action :set_cart

  def create
    product = Product.find(params[:product_id])
    cart_item = @cart.cart_items.find_or_initialize_by(product: product)
    cart_item.quantity = (cart_item.quantity || 0) + 1
    if cart_item.save
      flash[:notice] = "Product added to cart."
    else
      falsh[:alert] = "Could not add product to cart."
    end
    redirect_to cart_path
  end
  def edit
    @cart_item = @cart.cart_items.find(params[:id])
  end

  def update
    cart_item = @cart.cart_items.find(params[:id])
    if cart_item.update(quantity: params[:cart_item][:quantity])
      flash[:notice] = "Cart Updated."
    else
      flash[:notice] = "Could not update cart."
    end
    redirect_to cart_path
  end

  def destroy
    cart_item = @cart.cart_items.find(params[:id])
    cart_item.destroy
    flash[:notice] = "Item removed from cart."
    redirect_to cart_path
  end



  private

  def set_cart
    @cart = current_user.cart || current_user.create_cart
  end
end
