class Like < ApplicationRecord
  belongs_to :post
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'

  after_create -> { update_like_counter_add }
  after_destroy -> { update_like_counter_remove }

  def update_like_counter_add
    post.increment!(:likescounter)
  end

  def update_like_counter_remove
    post.decrement!(:likescounter)
  end
end
