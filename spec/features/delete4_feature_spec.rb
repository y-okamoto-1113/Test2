# feature spec
# describe = context => feature
# it = example =>       scenario
# let =>                given
# before =>             background
# visit =>              GET

require 'rails_helper'
RSpec.feature 'Pages', type: :feature do
  feature 'ログインした状態でアクションが成功するか' do
    # login    
    feature 'GET系は成功する' do
      given(:user) { create(:user) }
      scenario 'index, show, new, edit' do
        visit '/'
        
        visit '/users/3'   # /users/:idだとエラーが起きるので、idを直接指定指定ます。
        visit '/users/3/edit' 
        visit '/users/new' 
        expect(response).to have_http_status(:success)
      end
    end
    feature 'なぜかPOST系は失敗する' do
      given(:user) { create(:user) }
      scenario 'create' do
        post '/users/3/create'
        expect(response).to have_http_status(:success)
      end
      scenario 'update' do
        patch '/users/3'
        expect(response).to have_http_status(:success)
      end
      scenario 'delete' do
        delete '/users/3'
        expect(response).to have_http_status(:success)
      end
    end
  end
end
