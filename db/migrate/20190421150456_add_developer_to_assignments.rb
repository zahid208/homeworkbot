class AddDeveloperToAssignments < ActiveRecord::Migration[5.2]
  def change
    add_column :assignments, :developer_price, :float
    add_column :assignments, :due_date, :datetime
    add_reference :assignments, :developer, index: true
    add_foreign_key :assignments, :developers
  end
end
