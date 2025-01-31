class AddUserRefToShippingDetail < ActiveRecord::Migration[7.2]
  def change
    add_reference :shipping_details, :user, null: false, foreign_key: true
  end
end
