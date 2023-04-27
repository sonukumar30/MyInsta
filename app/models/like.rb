class Like < ApplicationRecord
  validates :user_id, uniqueness: {scope: [:likeable_id, :likeable_type] }
  belongs_to :user
  belongs_to :likeable, polymorphic: true

  scope :comment, ->{ where(:likeable_type => 'Comment') }
  scope :post, -> { where(:likeable_type => 'Post') }
end
