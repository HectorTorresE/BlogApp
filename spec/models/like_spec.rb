require 'rails_helper'

RSpec.describe Comment, type: :model do
  before do
    @author = User.new(name: 'Mateo', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Peru.',
                       postscounter: 0)
    @author.save
    @post = Post.new(author: @author, title: 'Title', text: 'Text', commentscounter: 0, likescounter: 0)
    @post.save
    @like = Like.new(author: @author, post: @post)
    @like.save
  end

  it 'should have a update_like_counter_add method that increments the post likes counter by 1' do
    expect(@post.likescounter).to eq(1)
    @like.update_like_counter_add
    expect(@post.likescounter).to eq(2)
  end

  it 'should have a update_like_counter_remove method that decrements the post likes counter by 1' do
    expect(@post.likescounter).to eq(1)
    @like.update_like_counter_remove
    expect(@post.likescounter).to eq(0)
  end
end
