class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :likes
  has_many :comments

  def update_post_counter
    count = author.postscounter
    count.nil? ? author.update(postscounter: 1) : author.update(postscounter: count + 1)
  end

  def five_recent_comments
    comments.where(post: self).order(created_at: :desc).limit(5)
  end
end
