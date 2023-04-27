class Community < ApplicationRecord
    has_many :groups,dependent: :destroy
    has_many :users, through: :groups

    validates :name, presence: true, length:{minimum:5,maximum:100}
end
