class AddAdminToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :manager, :boolean, default: false
  end
end
