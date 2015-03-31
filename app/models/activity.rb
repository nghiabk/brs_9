class Activity < ActiveRecord::Base
  belongs_to :user
  has_many :likes, dependent: :destroy
  
  validates :target_id, :action_type, presence: true

  def message
    message = " "
    case self.action_type
    when "Read"
      book = Book.find self.target_id
      return message + "read book #{book.title}"
    when "Reading"
      book = Book.find self.target_id
      return message + "is reading book #{book.title}"
    when "comment"  
      review = Review.find self.target_id
      return message + "write comment in review of #{review.user.username} 
                                for book #{review.book.title}"
    when "favorite"
      book = Book.find self.target_id
      return message + "favorite book #{book.title}"
    when "review"
      review = Review.find self.target_id
      return message + "write review for book #{review.book.title}"
    when "follow"
      user = User.find self.target_id
      return message + "follow #{user.username}"
    when "unfollow"
      user = User.find self.target_id
      return message + "unfollow #{user.username}"
    end  
  end  
end