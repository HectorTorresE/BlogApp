class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'

  def update_comment_counter
    count = post.commentscounter
    count.nil? ? post.update(commentscounter: 1) : post.update(commentscounter: count + 1)
  end
end
