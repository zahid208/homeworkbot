ActiveAdmin.register Assignment do
  permit_params :title, :body, :bid, :price, :field, :bid_accepted,
                :accepted_price, :account_id, :developer_price, :developer_id,
                :due_date

  scope :bid_accepted, default: true
  scope :pending

  controller do
    def scoped_collection
      current_admin_user.assignments
    end
  end

  index do
    selectable_column
    id_column
    column :title
    column :price
    column :field
    column :bid
    column :bid_accepted

    actions defaults: true do |assignment|
      if assignment.bid_accepted?
        link_to 'Bid Rejected', mark_accepted_admin_assignment_path(assignment, status: false), class: "member_link"
      else
        link_to 'Bid Accepted', mark_accepted_admin_assignment_path(assignment, status: true), class: "member_link"
      end
    end
  end

  form do |f|
    f.inputs do
      f.input :account
      f.input :title
      f.input :developer
      f.input :accepted_price
      f.input :developer_price
      f.input :due_date, as: :datepicker
      f.input :body
      f.input :bid
      f.input :price
      f.input :field
      f.input :bid_accepted

    end
    f.actions
  end

  member_action :mark_accepted do
    if resource.update(bid_accepted: params[:status])
      redirect_to admin_assignments_path, notice: "#{resource.title} was marked as #{params[:status] ? 'accepted.' : 'rejected.'}"
    else
      redirect_to admin_order_requests_path, alert: "Something went wrong! please try again."
    end
  end
end
