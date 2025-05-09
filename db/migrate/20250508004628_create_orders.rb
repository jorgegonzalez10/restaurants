class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.date :date
      t.string :name
      t.string :address
      t.float :total

      t.timestamps
    end
  end
end
