class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :likes
  has_many :comments

  def update_post_counter
    author.increment!(:postscounter)
  end

  def five_recent_comments
    comments.where(post: self).order(created_at: :desc).limit(5)
  end
end
