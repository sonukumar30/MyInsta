class Comment < ApplicationRecord
  belongs_to :post
  has_many :likes, as: :likeable,dependent: :destroy
  belongs_to :user

end
