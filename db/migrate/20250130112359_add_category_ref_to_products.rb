class AddCategoryRefToProducts < ActiveRecord::Migration[7.2]
  def change
    add_reference :products, :category
  end
end
