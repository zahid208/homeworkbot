ActiveAdmin.register Transaction do
  actions :index, :show
  config.per_page = [10, 100, 1000, 100000]

  index do
    selectable_column
    id_column
    column :processed_at
    column :payment_id
    column :reference_link
    column :event
    column :amount

    actions

    div class: "panel" do
      h3 "Total amount: $#{collection.sum(:amount)}"
    end
  end
end
