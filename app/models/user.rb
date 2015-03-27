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

  def review_for_book book
    self.reviews.select{|r| r.book_id == book.id}.first
  end

  def state_of_book book
    self.book_states.select{|r| r.book_id == book.id}.first
  end

  def favorite_of_book book
    self.favorites.select{|f| f.book_id == book.id}.first
  end  
end