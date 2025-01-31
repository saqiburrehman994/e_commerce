class Product < ApplicationRecord
  belongs_to :user, optional: true
  has_one_attached :image
  has_many :order_items, dependent: :destroy
  has_many :orders, through: :order_items
  has_many :cart_items, dependent: :destroy
  has_many :carts, through: :cart_items
  belongs_to :category

  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true, numericality: { greater_than: 0}
  validates :stock_quantity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0}
end
