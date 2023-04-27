class Group < ApplicationRecord


  belongs_to :community
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships
  
  validates :name, presence: true, length:{minimum:3,maximum:100}

end
