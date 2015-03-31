class User < ActiveRecord::Base
  validates :username, presence: true
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :image, ImageUploader

  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :book_states, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :relationships
  has_many :activities, dependent: :destroy
  has_many :requests, dependent: :destroy
  has_many :active_relationships, class_name:  'Relationship',
                                  foreign_key: 'follower_id',
                                  dependent:   :destroy
  has_many :passive_relationships, class_name:  'Relationship',
                                   foreign_key: 'followed_id',
                                   dependent:   :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  def is_admin?
    self.role == "admin"
  end

  def is_user? user
    self == user
  end 

  def review_for_book book
    self.reviews.select{|r| r.book_id == book.id}.first
  end

  def state_of_book book
    self.book_states.select{|r| r.book_id == book.id}.first
  end

  def favorite_of_book book
    self.favorites.select{|f| f.book_id == book.id}.first
  end

  def follow other_user
    active_relationships.create followed_id: other_user.id
    Activity.create user: self, target_id: other_user.id, action_type: "follow"
  end

  def unfollow other_user
    active_relationships.find_by(followed_id: other_user.id).destroy
    Activity.create user: self, target_id: other_user.id, action_type: "unfollow"
  end

  def following? other_user
    following.include? other_user
  end

  def get_relationship? user
    self.active_relationships.find_by followed_id: user.id
  end

  def to_param
    [id, username.parameterize].join("-")
  end

  def like? activity
    !self.likes.find_by(activity: activity).nil?
  end

  def load_favorites
    Book.where id: self.favorites.map(&:book_id)
  end  
end