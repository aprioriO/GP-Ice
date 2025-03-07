class CreateInventories < ActiveRecord::Migration[7.1]
  def change
    create_table :inventories do |t|
      t.references :product, null: false, foreign_key: true
      t.references :van, null: false, foreign_key: true
      t.integer :quantity_available

      t.timestamps
    end
  end
end
