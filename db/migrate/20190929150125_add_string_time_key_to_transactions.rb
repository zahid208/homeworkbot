class AddStringTimeKeyToTransactions < ActiveRecord::Migration[5.2]
  def change
    add_column :transactions, :string_time_key, :string
    add_column :accounts, :last_calculated_page, :integer, default: 1
  end
end
