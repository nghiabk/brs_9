class BookState < ActiveRecord::Base
  belongs_to :user
  belongs_to :book

  validates :state, presence: true
end