class Order < ApplicationRecord
  belongs_to :user

  validates :status_2, presence: true
end
