class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.references :van, null: false, foreign_key: true
      t.boolean :confirmed_status
      t.boolean :paid_status

      t.timestamps
    end
  end
end
