class Book < ActiveRecord::Base
  belongs_to :category
  has_many :reviews, dependent: :destroy
  has_many :image_books, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_states, dependent: :destroy
  
  validates :title, presence: true, length: {minimum: 6}
  validates :author, presence: true, length: {minimum: 6}
  validates :publish_date, :number_page, :rating, presence: true
  validate :image_size

  mount_uploader :image, ImageUploader
  
  private

  def image_size
    errors.add(:image, "should be less than 5MB") if image.size > 5.megabytes
  end
end