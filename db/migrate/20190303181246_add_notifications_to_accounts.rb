class AddNotificationsToAccounts < ActiveRecord::Migration[5.2]
  def change
    add_column :accounts, :notifications, :integer, default: 0
  end
end
