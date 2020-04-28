class CreateFilters < ActiveRecord::Migration[5.2]
  def change
    create_table :filters do |t|
      t.references :account, index: true
      t.integer :filter_type, default: 0
      t.integer :condition, default: 0
      t.string :value

      t.timestamps
    end
    add_foreign_key :filters, :accounts, on_delete: :cascade
  end
end
