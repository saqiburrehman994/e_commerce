class CreateShippingDetails < ActiveRecord::Migration[7.2]
  def change
    create_table :shipping_details do |t|
      t.string :name
      t.text :address
      t.string :phone_number
      t.timestamps
    end
  end
end
