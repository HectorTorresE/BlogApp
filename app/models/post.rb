class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :likes
  has_many :comments
  validates :title, presence: true
  validates :title, length: { maximum: 250 }
  validates :commentscounter, :likescounter, numericality: { greater_than_or_equal_to: 0 }

  def update_post_counter
    author.increment!(:postscounter)
  end

  def five_recent_comments
    comments.where(post: self).order(created_at: :desc).limit(5)
  end

  def liked?(user)
    likes.where(author: user).any?
  end
end
