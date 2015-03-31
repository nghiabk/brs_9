class Review < ActiveRecord::Base
  belongs_to :book
  belongs_to :user
  has_many :comments, dependent: :destroy
  
  before_destroy {Activity.find_by(action_type: "review", target_id: self.id).destroy}

  validates :content, :rate, presence: true 
end