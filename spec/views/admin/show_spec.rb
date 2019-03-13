require 'rails_helper'
# binding.pry
RSpec.describe 'Pages', type: :request do
  describe 'GET #ishow' do
    context 'with authentication' do
      login
      # adminでログインしてから、showアクションに入る。
      it 'return success status' do
        get "/users/3"        # 「/users/:id」だとidが番号に変換されへんから。番号を直接埋め込む
        expect(response).to have_http_status(:success)
      end
    end
    context 'without authentication' do
      # ログインせずに、showアクションに入る。
      it 'return fail status' do
        get "/users/3"        # 「/users/:id」だとidが番号に変換されへんから。番号を直接埋め込む
        expect(response).to have_http_status(302)
      end
    end
  end
end