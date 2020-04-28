class CreateAssignments < ActiveRecord::Migration[5.2]
  def change
    create_table :assignments do |t|
      t.string :title
      t.string :body
      t.boolean :bid
      t.float :price
      t.string :link
      t.string :slug
      t.string :field
      t.boolean :bid_accepted
      t.float :accepted_price

      t.timestamps
    end
  end
end
