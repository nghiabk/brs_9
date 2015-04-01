class Activity < ActiveRecord::Base
  belongs_to :user
  has_many :likes, dependent: :destroy
  
  after_create :create_message

  validates :target_id, :action_type, presence: true

  private
  def create_message
    case self.action_type
    when "Read"
      book = Book.find self.target_id
      message = "read book #{book.title}"
    when "Reading"
      book = Book.find self.target_id
      message = "is reading book #{book.title}"
    when "comment"  
      comment = Comment.find self.target_id
      message = "write comment in review of #{comment.review.user.username} 
                                for book #{comment.review.book.title}"
    when "favorite"
      book = Book.find self.target_id
      message = "favorite book #{book.title}"
    when "review"
      review = Review.find_by id: self.target_id
      message = "write review for book #{review.book.title}"
    when "follow"
      user = User.find self.target_id
      message = "follow #{user.username}"
    when "unfollow"
      user = User.find self.target_id
      message = "unfollow #{user.username}"
    end 
    self.update_attributes message: message 
  end  
end