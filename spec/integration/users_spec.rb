require 'rails_helper'

RSpec.describe 'Users', type: :system do
  before(:all) do
    Capybara.configure do |config|
      config.run_server = false
    end
    session = Capybara::Session.new(:selenium)
    @first_user = User.create(name: 'Tom',
                              photo: 'https://cdn.discordapp.com/attachments/924502144810360833/1009475393054576671/e.png', bio: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', postscounter: 0)
    @second_user = User.create(name: 'Lilly',
                               photo: 'https://cdn.discordapp.com/attachments/924502144810360833/1009475393054576671/e.png', bio: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua', postscounter: 0)
    @first_post = Post.create(title: 'Title', text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', commentscounter: 0, likescounter: 0,
                              author: @first_user)
    @second_post = Post.create(title: 'Title', text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', commentscounter: 0, likescounter: 0,
                               author: @first_user)
    @third_post = Post.create(title: 'Title', text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', commentscounter: 0, likescounter: 0,
                              author: @first_user)
  end

  it 'should show the username of all existing users' do
    visit('http://localhost:3000/')
    expect(page).to have_content('Lilly')
    expect(page).to have_content('Tom')
  end

  it 'should show the profile picture for each user.' do
    visit('http://localhost:3000/')
    expect(page).to have_xpath("//img[contains(@src,'https://cdn.discordapp.com/attachments/924502144810360833/1009475393054576671/e.png')]")
  end

  it 'should show the number of posts each user has written' do
    visit('http://localhost:3000/')
    expect(page).to have_content('Number of Posts: 3')
  end

  it 'should redirected to that user\'s show page, when the username is clicked.' do
    visit('http://localhost:3000/')
    click_on 'Tom'
    expect(page).to have_current_path(user_path(@first_user))
  end

  it 'show user\'s name' do
    visit('http://localhost:3000/users/1')
    expect(page).to have_content('Tom')
  end

  it 'show user\'s image' do
    visit('http://localhost:3000/users/1')
    expect(page).to have_xpath("//img[contains(@src,'https://cdn.discordapp.com/attachments/924502144810360833/1009475393054576671/e.png')]")
  end

  it 'show number of post' do
    visit('http://localhost:3000/users/1')
    expect(page).to have_content('Number of Posts: 3')
  end

  it 'show the users bio' do
    visit('http://localhost:3000/users/1')
    expect(page).to have_content('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.')
  end

  it 'show the user\'s first 3 posts' do
    visit('http://localhost:3000/users/1')
    posts = page.find_all('div', class: 'post_info')
    expect(posts.length).to eq(3)
  end

  it 'show button that redirects to user\'s post' do
    visit('http://localhost:3000/users/1')
    expect(page).to have_content('See all posts')
  end

  it 'redirects me to the post\'s show page' do
    visit('http://localhost:3000/users/1')
    post = find_link(href: "/users/#{@first_user.id}/posts/#{@third_post.id}")
    post.click
    expect(page).to have_current_path(user_post_path(user_id: @first_user.id, id: @third_post.id))
  end

  it 'redirects to the post\'s index page' do
    visit('http://localhost:3000/users/1')
    button = page.find_link('See all posts')
    button.click
    expect(page).to have_current_path(user_posts_path(user_id: @first_user.id))
  end
end

