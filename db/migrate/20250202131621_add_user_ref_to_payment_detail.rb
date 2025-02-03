class AddUserRefToPaymentDetail < ActiveRecord::Migration[7.2]
  def change
    add_reference :payment_details, :user
  end
end
