class Request < ActiveRecord::Base
  belongs_to :user
  validates :book_name, :book_url, presence: true
  validates :book_url, uniqueness: true
  
  def is_accepted?
    self.state == "accepted"
  end

  def is_rejected?
    self.state == "rejected"
  end
end