require 'rails_helper'
# binding.pry
RSpec.describe 'Pages', type: :request do
  describe 'GET #new' do
    context 'with authentication' do
      login
      # adminでログインしてから、newアクションに入る。
      it 'return success status' do
        get '/users/new'
        expect(response).to have_http_status(:success)
      end
    end
    context 'without authentication' do
      # ログインせずに、newアクションに入る。
      it 'return fail status' do
        get '/users/new'
        expect(response).to have_http_status(302)
      end
    end
  end
end