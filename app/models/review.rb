class Review < ApplicationRecord
  belongs_to :product
  belongs_to :user
  validates :rating, inclusion: { in: 1..5 }
  validates :comment, presence: true
end
