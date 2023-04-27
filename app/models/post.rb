class Post < ApplicationRecord
    has_many :comments,dependent: :destroy
    
    validates :title, presence: true, length:{minimum:3,maximum:100}
    validates :description, presence: true,length:{minimum:3,maximum:1000}
    validates :keyword, presence: true,length:{minimum:3,maximum:100}

    has_many_attached :images
    has_many :likes, as: :likeable
    belongs_to :user


    scope :Hello, -> {
      where(:title => "Hello")
    }

  
end
