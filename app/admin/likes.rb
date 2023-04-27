ActiveAdmin.register Like do
  permit_params :likeable_id, :likeable_type, :user_id

  scope :all
  
  scope :comment, :default => true do |like|
    Like.comment
  end
  scope :post, :default => true do |like|
    Like.post
  end
  

  filter :user_email,as: :string
  filter :likeable_type, as: :string
  filter :created_at
  index do
    selectable_column
    column :id
    column :user
    column :likeable
    column :likeable_type
    column :created_at
    actions
  end
  
end
