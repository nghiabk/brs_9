class Review < ActiveRecord::Base
  belongs_to :book
  belongs_to :user
  has_many :comments, dependent: :destroy
  
  before_destroy :destroy_activity
  after_create :update_rating
  after_update :update_rating
  after_destroy :update_rating

  validates :content, :rate, presence: true 

  private
  def update_rating
    self.book.update_attributes rating: self.book.calculate_rating.round(2)
  end  

  def destroy_activity
    Activity.find_by(action_type: "review", target_id: self.id).destroy
  end  
end