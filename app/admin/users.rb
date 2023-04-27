ActiveAdmin.register User do

  permit_params :email, :password, :password_confirmation

  filter :email
  filter :created_at
  index do
    selectable_column
    column :id
    column :email
    column :created_at
    actions
  end
end
