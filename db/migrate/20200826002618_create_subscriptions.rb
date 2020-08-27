class CreateSubscriptions < ActiveRecord::Migration[6.0]
  def change
    create_table :subscriptions do |t|
      t.string :plan, null: false, unique: true
      t.decimal :price, precision: 10, scale: 2, null: false
      t.string :frequency, default: :monthly, null: false

      # other attrs

      t.timestamps
    end
  end
end
