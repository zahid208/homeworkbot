ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    columns do
      column do
        panel "Running Processes", class: 'overflow-auto' do
          current_admin_user.accounts.each do |account|
            h4 "--> ##{account.id} #{account.title || account.email}"
            pre %x[ps #{account.pid}] if account.pid.present?
          end

          h4 "----> Ruby Processes"
          pre %x[ps ax | grep ruby]
        end
      end
    end
  end
end
