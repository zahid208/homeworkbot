class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.datetime :processed_at
      t.string :payment_id
      t.string :reference_link
      t.string :event
      t.float :amount
      t.float :change
      t.float :balance
      t.references :account, index: true

      t.timestamps
    end
    add_foreign_key :transactions, :accounts, on_delete: :cascade
  end
end
