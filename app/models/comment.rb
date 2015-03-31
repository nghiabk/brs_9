class Comment < ActiveRecord::Base
  belongs_to :review
  belongs_to :user
  belongs_to :book

  before_destroy :destroy_activity
  
  validates :content, presence: true

  def destroy_activity
    Activity.find_by(action_type: "comment", target_id: self.id).destroy
  end  
end