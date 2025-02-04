class Product < ApplicationRecord
  belongs_to :user, optional: true
  has_one_attached :image
  has_many :order_items, dependent: :destroy
  has_many :orders, through: :order_items
  has_many :cart_items, dependent: :destroy
  has_many :carts, through: :cart_items
  has_many :reviews, dependent: :destroy
  belongs_to :category

  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :stock_quantity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  scope :by_category, ->(category_name) {
    joins(:category).where("categories.name ILIKE ?", "#{category_name}")
  }
  scope :by_price_range, ->(min_price, max_price) {
    where(price: min_price..max_price)
  }
end
