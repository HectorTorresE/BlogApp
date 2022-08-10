class Like < ApplicationRecord
  belongs_to :post
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'

  def update_like_counter
    count = post.likescounter
    count.nil? ? post.update(likescounter: 1) : post.update(likescounter: count + 1)
  end
end
