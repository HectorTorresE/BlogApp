require 'rails_helper'

RSpec.describe 'Posts', type: :system do
  before(:all) do
    Capybara.configure do |config|
      config.run_server = false
    end
    @first_user = User.create(name: 'Tom',
                              photo: 'https://cdn.discordapp.com/attachments/924502144810360833/1009475393054576671/e.png',
                              bio: 'Lorem ipsum dolor sit amet', postscounter: 0)
    @second_user = User.create(name: 'Lilly',
                               photo: 'https://cdn.discordapp.com/attachments/924502144810360833/1009475393054576671/e.png',
                               bio: 'Lorem ipsum dolor sit amet', postscounter: 0)
    @first_post = Post.create(title: 'Title', text: 'Lorem ipsum dolor sit amet', commentscounter: 3, likescounter: 0,
                              author: @first_user)
    @second_post = Post.create(title: 'Title', text: 'Lorem ipsum dolor sit amet', commentscounter: 0, likescounter: 0,
                               author: @first_user)
    @third_post = Post.create(title: 'Title', text: 'Lorem ipsum dolor sit amet', commentscounter: 0, likescounter: 0,
                              author: @first_user)
    @first_comment = Comment.create(post: @first_post, author: @first_user, text: 'Hi Tom first!')
    @second_comment = Comment.create(post: @first_post, author: @first_user, text: 'Hi Tom second')
    @third_comment = Comment.create(post: @first_post, author: @first_user, text: 'Hi Tom third')
    @first_like = Like.create(post: @first_post, author: @first_user)
    @second_like = Like.create(post: @first_post, author: @first_user)
  end

  it 'should have the user\'s profile picture' do
    visit('http://localhost:3000/users/1/posts')
    expect(page).to have_xpath("//img[contains(@src,'https://cdn.discordapp.com/attachments/924502144810360833/1009475393054576671/e.png')]")
  end

  it 'Should have the user\'s name' do
    visit('http://localhost:3000/users/1/posts')
    expect(page).to have_content(@first_user.name)
  end

  it 'See the number of posts each user has written' do
    visit('http://localhost:3000/users/1/posts')
    expect(page).to have_content('Number of Posts: 3')
  end

  it 'See some of the post body' do
    visit('http://localhost:3000/users/1/posts')
    post = page.find_all('.post_info').first
    expect(post).to have_content(@third_post.text)
  end

  it 'I can see the first comments on a post' do
    visit('http://localhost:3000/users/1/posts')
    comment_container = page.find_all('.comments_container').last
    comment = comment_container.find_all('li').first
    expect(comment).to have_content(@first_comment.text)
  end

  it 'See how many comments a post has.' do
    visit('http://localhost:3000/users/1/posts')
    post = page.find_all('.post_info').first
    expect(post).to have_content('Comments:')
  end

  it 'See how many likes a post has.' do
    visit('http://localhost:3000/users/1/posts')
    post = page.find_all('.post_info').first
    expect(post).to have_content('Likes:')
  end

  it 'see a section for pagination if there are more posts than fit on the view.' do
    visit('http://localhost:3000/users/1/posts')
    expect(page).to have_content('Pagination')
  end

  it "click a user's post, it redirects me to that post's show page" do
    visit('http://localhost:3000/users/1/posts')
    post = find_link(href: "/users/#{@first_user.id}/posts/#{@third_post.id}")
    post.click
    expect(page).to have_current_path(user_post_path(user_id: @first_user.id, id: @third_post.id))
  end

  it 'I can see who wrote the post.' do
    visit('http://localhost:3000/users/1/posts/1')
    expect(page).to have_content("by #{@first_user.name}")
  end

  it 'See how many comments it has.' do
    visit('http://localhost:3000/users/1/posts/1')
    expect(page).to have_content('Comments: 3')
  end

  it 'See how many likes it has' do
    visit('http://localhost:3000/users/1/posts/1')
    expect(page).to have_content('Likes: 2')
  end

  it 'See all the post body' do
    visit('http://localhost:3000/users/1/posts/1')
    expect(page).to have_content('Lorem ipsum dolor sit amet')
  end

  it 'See the username of each commentor.' do
    visit('http://localhost:3000/users/1/posts/1')
    comment_container = find_all('.comments_container').first
    expect(comment_container).to have_content(@first_comment.author.name)
    expect(comment_container).to have_content(@second_comment.author.name)
    expect(comment_container).to have_content(@third_comment.author.name)
  end

  it 'See the comment each commentor left' do
    visit('http://localhost:3000/users/1/posts/1')
    comment_container = find_all('.comments_container').first
    expect(comment_container).to have_content(@first_comment.text)
    expect(comment_container).to have_content(@second_comment.text)
    expect(comment_container).to have_content(@third_comment.text)
  end
end
