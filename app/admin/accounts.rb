ActiveAdmin.register Account do
  permit_params :email, :password, :bid_content, :title, :channel
  actions :all, except: [:destroy]

  controller do
    def scoped_collection
      current_admin_user.accounts
    end
  end

  form do |f|
    f.inputs do
      f.input :admin_user, input_html: { disabled: true }
      f.input :title
      f.input :email
      f.input :password
      f.input :bid_content
      f.input :channel
    end
    f.actions
  end

  index do
    selectable_column
    id_column
    column :title
    column :email

    column 'Start Bidding' do |account|
      link_to 'Start Bidding Process', start_bidding_admin_account_path(account)
    end

    actions
  end

  show do
    default_main_content

    panel "Bidding Process", class: 'overflow-auto' do
      pre do
        %x[ps #{resource.pid}] if account.pid.present?
      end
    end
  end

  action_item :start_bidding, only: :show do
    link_to 'Start Bidding Process', start_bidding_admin_account_path(account)
  end

  member_action :start_bidding do
    `sudo systemctl start bot`
    redirect_to admin_account_path(resource), notice: "Bidding was started successfully!"
  end

  action_item :stop_bidding, only: :show do
    link_to 'Stop Bidding Process', stop_bidding_admin_account_path(account)
  end

  member_action :stop_bidding do
    `sudo systemctl stop bot`
    redirect_to admin_account_path(resource), notice: "Bidding was stoped successfully!"
  end
end
