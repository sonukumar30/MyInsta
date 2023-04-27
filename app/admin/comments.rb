ActiveAdmin.register Comment do

  permit_params :body , :user_id, :post_id

  filter :post_title,as: :string
  filter :created_at
  index do
    selectable_column
    column :id
    column :post
    column :user
    column :created_at
    actions
  end
  
end
