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

  accepts_nested_attributes_for :photos, 
  :reject_if => lambda {|a| a[:image].blank?}, allow_destroy: true

  private
  def has_important_photo
    unless photos.any? {|photo| photo.important?}
      errors.add(:base, "You have to choose a important photo!")
    end
  end
end