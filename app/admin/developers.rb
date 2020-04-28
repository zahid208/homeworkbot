ActiveAdmin.register Developer do
  actions :all, except: :destroy
  permit_params :full_name, :phone, :email

  show do
    default_main_content

    panel "Assignments" do
      table_for developer.assignments do
        column :title
        column :due_date
        column :accepted_price
        column :developer_price

        column 'Action' do |assignment|
          link_to 'Edit', edit_admin_assignment_path(assignment)
        end
      end
    end
  end
end
