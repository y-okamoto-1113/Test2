require 'rails_helper'
RSpec.describe 'Pages', type: :request do
  describe 'ログインした状態でアクションが成功するか' do
    login
    describe 'GET系は成功する' do
      let(:user) { create(:user) }
      example 'index, show, new, edit' do
        get '/'
        get '/users/3'   # /users/:idだとエラーが起きるので、idを直接指定指定ます。
        get '/users/3/edit' 
        get '/users/new' 
        expect(response).to have_http_status(:success)
      end
    end
    describe 'なぜかPOST系は失敗する' do
      let(:user) { create(:user) }
      example 'create' do
        post '/users/3/create'
        expect(response).to have_http_status(:success)
      end
      example 'update' do
        patch '/users/3'
        expect(response).to have_http_status(:success)
      end
      example 'delete' do
        delete '/users/3'
        expect(response).to have_http_status(:success)
      end
    end
  end
end
