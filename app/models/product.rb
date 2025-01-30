class Product < ApplicationRecord
  belongs_to :user, optional: true
  has_one_attached :image
  has_many :order_items
  has_many :orders, through: :order_items
end
