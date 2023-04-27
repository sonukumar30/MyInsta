ActiveAdmin.register Post do
  permit_params :user_id, :title, :description, :keyword,images:[]
  
  scope :all
  scope :Hello

  filter :title
  filter :user_email,as: :string
  filter :created_at

  
  index do
    selectable_column
    column :id
    column :title
    column :user
    column :created_at
    column :like_count
    actions
  end

  
end
