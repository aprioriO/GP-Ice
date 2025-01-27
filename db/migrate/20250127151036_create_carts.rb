class CreateCarts < ActiveRecord::Migration[7.1]
  def change
    create_table :carts do |t|
      t.references :user, null: false, foreign_key: true
      t.references :van, null: false, foreign_key: true
      t.boolean :status

      t.timestamps
    end
  end
end
