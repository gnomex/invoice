class CreateAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :accounts do |t|
      t.string :code, null: false, unique: true
      t.belongs_to :subscription, index: true

      # other attrs

      t.timestamps
    end
  end
end
