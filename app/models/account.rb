class Account < ApplicationRecord
  belongs_to :user

  validates :name, presence: true, length:{minimum:5,maximum:25}

end
