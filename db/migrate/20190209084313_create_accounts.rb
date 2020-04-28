class CreateAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :accounts do |t|
      t.string :title
      t.string :email
      t.string :password
      t.text :bid_content
      t.references :admin_user, index: true

      t.timestamps
    end
    add_foreign_key :accounts, :admin_users, on_delete: :cascade

    add_reference :assignments, :account, index: true
    add_foreign_key :assignments, :accounts, on_delete: :cascade
  end
end
