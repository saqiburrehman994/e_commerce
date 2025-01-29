class Product < ApplicationRecord
  belongs_to :user, -> { where manager: true }
end
