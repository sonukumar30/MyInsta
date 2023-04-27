ActiveAdmin.register Account do

 permit_params :user_id,:name,:address,:phone


  filter :name
  filter :user_email,as: :string
  filter :created_at
  index do
    selectable_column
    column :id
    column :name
   
    column :created_at
    actions
  end
  
end
