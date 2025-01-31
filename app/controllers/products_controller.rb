class ProductsController < ApplicationController
  before_action :set_product, only: [ :edit, :update, :destroy ]

  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new(user: current_user)
    if can? :new, @product
      render :new
    else
      head :forbidden
    end
  end

  def create
    @product = current_user.products.new(product_params)
    if @product.save
       redirect_to products_path, notice: "Product was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    if can? :edit, @product
      render :edit
    else
      head :forbidden
    end
  end

  def update
    if @product.update
      redirect_to products_path, notice: "Product was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize! :destroy, @product
    @product.destroy
    redirect_to products_path, notice: :"Product was successfully deleted."
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :price, :stock_quantity, :category_id, :image)
  end

  def set_product
    @product = current_user.products.find(params[:id])
  end
end
