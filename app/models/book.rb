class Book < ActiveRecord::Base
  belongs_to :category

  has_many :reviews, dependent: :destroy
  has_many :photos, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_states, dependent: :destroy
  
  validates :title, presence: true, length: {minimum: 6}
  validates :author, presence: true, length: {minimum: 6}
  validates :publish_date, :number_page, :rating, presence: true
  validate :has_important_photo

  accepts_nested_attributes_for :photos, allow_destroy: true
  
  def calculate_rating
    rates = self.reviews.collect{|r| r.rate if r.rate > 0}
    return rates.size == 0 ? 0 : rates.sum / rates.size
  end

  def important_photo
    self.photos.select{|p| p.important == true}.first
  end  
  
  private
  def image_size
    errors.add(:image, "should be less than 5MB") if image.size > 5.megabytes
  end

  def has_important_photo
    unless photos.any? {|photo| photo.important?}
      errors.add(:base, "You have to choose a important photo!")
    end
  end

  def self.search(search, filter)
    search ? where("#{filter} LIKE ?", "%#{search}%") : all
  end     
end