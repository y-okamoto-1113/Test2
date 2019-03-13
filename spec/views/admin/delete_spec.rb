require 'rails_helper'
# binding.pry
RSpec.describe 'Pages', type: :request do

  describe 'Delete user' do
    context 'with authentication' do
      login
      let(:user) { create(:user) }
      # adminでログインしてから、ユーザー消す。
      it 'return success status' do
        binding.pry
        delete '/users/3'
        binding.pry
        # delete user
        # binding.pry
        delete user_path
        binding.pry
        delete user_path(id: 3)
        # binding.pry
        # delete :destroy, params: { id: user }
        # binding.pry
        # delete :destroy, params: { id: user.id }
        # binding.pry
        # delete :destroy, params: { id: user.id }
        binding.pry
        
        expect(response).to have_http_status(:success)
        # binding.pry
      end
    end
    context 'without authentication' do
      # ログインせずに、ユーザー消す。
      it 'return fail status' do
        delete '/users/3'
        expect(response).to have_http_status(302)
      end
    end
  end
end