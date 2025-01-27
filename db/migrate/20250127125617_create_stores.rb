class CreateStores < ActiveRecord::Migration[7.1]
  def change
    create_table :stores do |t|
      t.references :product, null: false, foreign_key: true
      t.references :van, null: false, foreign_key: true

      t.timestamps
    end
  end
end
