class Review < ActiveRecord::Base
  belongs_to :book
  belongs_to :user
  has_many :comments
  
  validates :content, :rate, presence: true 
end