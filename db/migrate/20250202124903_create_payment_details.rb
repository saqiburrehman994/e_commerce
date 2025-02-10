class CreatePaymentDetails < ActiveRecord::Migration[7.2]
  def change
    create_table :payment_details do |t|
      t.string :card_number
      t.string :expiry_date
      t.string :cvv

      t.timestamps
    end
  end
end
