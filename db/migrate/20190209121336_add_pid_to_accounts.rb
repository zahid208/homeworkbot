class AddPidToAccounts < ActiveRecord::Migration[5.2]
  def change
    add_column :accounts, :pid, :integer
  end
end
