require 'rails_helper'
require 'users_controller'

RSpec.describe UsersController , type: :controller do
  let(:admin) { create(:admin) }
  describe 'GET #index' do
    describe 'ログインしている場合' do
      before do
        sign_in admin
      end
      it 'アクセスが可能' do
        get :index
        expect(response).to have_http_status(:success)
      end
    end
    describe 'ログインしていない場合' do
      it '管理者のログインフォームへ遷移する' do
        get :index
        expect(response).to redirect_to new_admin_session_path
      end
    end
  end

  describe 'GET #show' do
    let(:user) { create(:user) }
    describe 'ログインしている場合' do
      before do
        sign_in admin
      end
      it 'アクセスが可能' do
        get :show, params: { id: user.id }
        expect(response).to have_http_status(:success)
      end
    end
    describe 'ログインしていない場合' do
      it '管理者のログインフォームへ遷移する' do
        get :show, params: { id: user.id }
        expect(response).to redirect_to new_admin_session_path
      end
    end
  end

  describe 'なぜかPOST系は失敗する' do
    let(:user) { create(:user) }
    example 'create' do
      post user_path(user)
      expect(response).to have_http_status(:success)
    end
    example 'update' do
      patch user_path(user.id)
      expect(response).to have_http_status(:success)
    end
    example 'delete' do
      delete user_path(user.id)
      expect(response).to have_http_status(:success)
    end
  end



end
