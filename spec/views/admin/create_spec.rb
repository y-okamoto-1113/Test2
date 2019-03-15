require 'rails_helper'
# binding.pry
RSpec.describe 'Pages', type: :request do
  describe 'create user' do
    context 'with authentication' do
      login
      # adminでログインしてから、ユーザー消す。
      it 'return success status' do
        create '/users'
        expect(response).to have_http_status(:success)
      end
    end
    context 'without authentication' do
      # ログインせずに、ユーザー消す。
      it 'return fail status' do
        create '/users'
        expect(response).to have_http_status(302)
      end
    end
  end
end