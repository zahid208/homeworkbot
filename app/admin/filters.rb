ActiveAdmin.register Filter do
  permit_params :filter_type, :condition, :value, :account_id
end
