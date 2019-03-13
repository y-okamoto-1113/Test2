require 'rails_helper'
# binding.pry
RSpec.describe 'Pages', type: :request do
  describe 'GET #index' do
    context 'with authentication' do
      login
      # adminでログインしてから、indexアクションに入る。
      it 'return success status' do
        patch '/users/3'
        expect(response).to have_http_status(:success)
      end
    end
    context 'without authentication' do
      # ログインせずに、indexアクションに入る。
      it 'return fail status' do
        patch '/users/3'
        expect(response).to have_http_status(302)
      end
    end
  end
end