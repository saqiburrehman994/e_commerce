class Category < ApplicationRecord
  has_ancestry
  has_many :products

  validates :name, presence: true
end
