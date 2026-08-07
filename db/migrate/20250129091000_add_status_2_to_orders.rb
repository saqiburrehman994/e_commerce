# frozen_string_literal: true

class AddStatus2ToOrders < ActiveRecord::Migration[7.2]
  def change
    add_column :orders, :status_2, :string, default: "pending", null: false
  end
end
