require 'rails_helper'

RSpec.describe 'Posts nested routes', type: :request do
  context 'GET /users/:user_id/posts' do
    it 'returns a 200 response' do
      get '/users/1/posts'
      expect(response).to have_http_status(200)
    end

    it 'renders the index view' do
      get '/users/1/posts'
      expect(response).to render_template(:index)
    end

    it 'renders a html containing a <h1>list of posts for a given user</h1> tag' do
      get '/users/1/posts'
      expect(response.body).to include('<h1>list of posts for a given user</h1>')
    end
  end

  context 'GET /users/:user_id/posts/:id' do
    it 'returns a 200 response' do
      get '/users/1/posts/1'
      expect(response).to have_http_status(200)
    end

    it 'renders the show view' do
      get '/users/1/posts/1'
      expect(response).to render_template(:show)
    end

    it 'renders a html containing a <h1>A post of a given user.</h1> tag' do
      get '/users/1/posts/1'
      expect(response.body).to include('<h1>A post of a given user.</h1>')
    end
  end
end
