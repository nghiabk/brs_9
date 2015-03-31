class Photo < ActiveRecord::Base
  belongs_to :book
  validates :image, presence: true
  
  mount_uploader :image, ImageUploader
end
