class CreateDevelopers < ActiveRecord::Migration[5.2]
  def change
    create_table :developers do |t|
      t.string :full_name
      t.string :phone
      t.string :email

      t.timestamps
    end
  end
end
