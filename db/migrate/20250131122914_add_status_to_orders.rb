class AddStatusToOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :status, :string, default: "pending"
  end
end
