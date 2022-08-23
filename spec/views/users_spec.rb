require 'rails_helper'

RSpec.describe 'Users', type: :feature do
  before(:all) do
    Capybara.configure do |config|
      config.run_server = false
    end
    session = Capybara::Session.new(:selenium)
    @first_user = User.create(name: 'Tom',
                              photo: 'https://cdn.discordapp.com/attachments/924502144810360833/1009475393054576671/e.png', bio: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ', postscounter: 0)
    @second_user = User.create(name: 'Lilly',
                               photo: 'https://cdn.discordapp.com/attachments/924502144810360833/1009475393054576671/e.png', bio: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua', postscounter: 0)
  end

  it 'should show the username of all existing users' do
    visit('http://localhost:3000/')
    expect(page).to have_content('Lilly')
    expect(page).to have_content('Tom')
  end

  it 'should show the profile picture for each user.' do
    visit('http://localhost:3000/')
    expect(page.find("##{@first_user.name}-img-#{@first_user.id}")['src']).to have_content('https://cdn.discordapp.com/attachments/924502144810360833/1009475393054576671/e.png')
    expect(page.find("##{@second_user.name}-img-#{@second_user.id}")['src']).to have_content('https://cdn.discordapp.com/attachments/924502144810360833/1009475393054576671/e.png')
  end

  it 'should show the number of posts each user has written' do
    visit('http://localhost:3000/')
    expect(page).to have_content('Number of Posts: 0')
  end
  it 'should redirected to that user\'s show page, when the username is clicked.' do
    visit('http://localhost:3000/')
    click_on 'Tom'
    expect(page).to have_current_path(user_path(@first_user))
  end
end
