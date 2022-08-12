require 'rails_helper'

RSpec.describe Comment, type: :model do
  before do
    @author = User.new(name: 'Mateo', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Peru.',
        postscounter: 0)
    @author.save
    @post = Post.new(author: @author, title: 'Title', text: 'Text', commentscounter: 0, likescounter: 0)
    @post.save
    @comment = Comment.new(author: @author, text: 'Comment Text', post: @post)
    @comment.save
  end

  it 'should have a update_comment_counter method that increments the post comment counter by 1' do
    expect(@post.commentscounter).to eq(0)
    @comment.update_comment_counter
    expect(@post.commentscounter).to eq(1)
  end
end