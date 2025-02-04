class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :products, dependent: :destroy
  has_one  :cart, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_one  :shipping_detail, dependent: :destroy
  has_one  :payment_detail
  has_many :reviews, dependent: :destroy


  def purchased?(product)
      orders.joins(:order_items).exists?( order_items: { product_id: product.id})
  end
end
