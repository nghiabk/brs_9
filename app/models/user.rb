class User < ActiveRecord::Base
  validates :username, presence: true
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :image, ImageUploader

  has_many :comments
  has_many :likes
  has_many :reviews
  has_many :book_states
  has_many :favorites
  has_many :relationships
  has_many :activities
  has_many :requests

  def is_admin?
    self.role == "admin"
  end

  def is_user? user
    self == user
  end 
end