class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  

  validates :email, format: URI::MailTo::EMAIL_REGEXP
  
  


 #group-community-associations
  has_many :memberships
  has_many :groups, through: :memberships
  has_many :communities, through: :groups
  

  has_many :likes
  has_many :posts
  has_one :account
  has_many :comments

  
   def self.authenticate(email, password)
    user = User.find_for_authentication(email: email)
    user&.valid_password?(password) ? user : nil
  end


after_create :create_account
  
private
    def create_account
      username = self.email.split('@').first.upcase
      Account.create(name:username, user_id: self.id)
    end
    
  
end
