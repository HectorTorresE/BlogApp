require 'rails_helper'

RSpec.describe 'Users routes', type: :request do
  context 'GET /users' do
    it 'returns a 200 response' do
      get '/users'
      expect(response).to have_http_status(200)
    end

    it 'renders the index view' do
      get '/users'
      expect(response).to render_template(:index)
    end

    it 'renders a html containing a <h1>List of users<h1> tag' do
      get '/users'
      expect(response.body).to include('<h1>List of users<h1>')
    end
  end

  context 'GET /users/:id' do
    it 'returns a 200 response' do
      get '/users/1'
      expect(response).to have_http_status(200)
    end

    it 'renders the show view' do
      get '/users/1'
      expect(response).to render_template(:show)
    end

    it 'renders a html containing a <h1>details of a given user</h1> tag' do
      get '/users/1'
      expect(response.body).to include('<h1>details of a given user</h1>')
    end
  end
end
