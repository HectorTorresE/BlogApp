require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = User.new(name: 'Mateo', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Peru.',
                     postscounter: 0)
    @user.save
  end

  it 'should have a name' do
    expect(@user.name).to eq('Mateo')
  end

  it 'should have a photo' do
    expect(@user.photo).to eq('https://unsplash.com/photos/F_-0BxGuVvo')
  end

  it 'should have a bio' do
    expect(@user.bio).to eq('Teacher from Peru.')
  end

  it 'should not be valid without a name' do
    @user.name = nil
    expect(@user).to_not be_valid
  end

  it 'should not be valid without a posts counter greater or equal to 0' do
    @user.postscounter = -1
    expect(@user).to_not be_valid
  end

  it 'should have a three_recent_post method that returns the 3 most recent posts' do
    post1 = Post.new(author: @user, title: 'Title 1', text: 'Text 1', commentscounter: 0, likescounter: 0)
    post1.save
    post2 = Post.new(author: @user, title: 'Title 2', text: 'Text 2', commentscounter: 0, likescounter: 0)
    post2.save
    post3 = Post.new(author: @user, title: 'Title 3', text: 'Text 3', commentscounter: 0, likescounter: 0)
    post3.save
    post4 = Post.new(author: @user, title: 'Title 4', text: 'Text 4', commentscounter: 0, likescounter: 0)
    post4.save
    post5 = Post.new(author: @user, title: 'Title 5', text: 'Text 5', commentscounter: 0, likescounter: 0)
    post5.save
    expect(@user.three_recent_post).to eq([post5, post4, post3])
  end
end