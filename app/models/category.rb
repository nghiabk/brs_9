class Category < ActiveRecord::Base
  has_many :books, dependent: :destroy
  
  mount_uploader :image, ImageUploader
  
  validates :name, presence: true, uniqueness: true
  validates :image, presence: true
  validate :image_size

  private
  def image_size
    if image.size > 5.megabytes
      errors.add(:image, "Should be less than 5MB")
    end
  end
end