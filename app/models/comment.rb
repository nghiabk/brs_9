class Comment < ActiveRecord::Base
  belongs_to :review
  belongs_to :user
  belongs_to :book

  before_destroy {Activity.find_by(action_type: "comment", target_id: self.id).destroy}
  
  validates :content, presence: true
end