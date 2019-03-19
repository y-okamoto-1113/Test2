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
# #############################################################################################
  describe 'POST系　ログインしてる' do
    let(:user) { create(:user) }
    before do
      sign_in admin
      FactoryBot.create :user
    end
    example 'create' do
      # post user_path(user)  引数とか書き方がおかしいからエラーでる
      post :create, params: {id: user.id} # users_controllerの「create」アクション内で「delete!」が定義されてへんって出るからコメントアウトしてからテスト
      # post :create, params: {post: user} # こっちでもいける
      expect(response).to have_http_status(:success)
    end
    example 'update' do
      # patch user_path(user.id)
      patch :update, params: {id: user.id}
      expect(response).to have_http_status(:success)
    end
    example 'delete' do
      # delete user_path(user.id)
      binding.pry
      # users.count
      # aaa = User.count #削除される前のユーザーの総数
      delete :destroy, params: {id: user.id}
      expect(response).to have_http_status(302)
      # bbb = User.count #削除された後のユーザー総数
      binding.pry
      # これ動かん。 ユーザー削除できてるのに何故かカウント数
      # expect(aaa-1).to eq(bbb) # ちゃんと1個削除されているかを確かめてる 「eq(bbb)」の「bbb」は「User.count」と書ける。

      expect( User.find_by(id: user.id) ).to eq(nil) #削除されたユーザーがちゃんとnilになってるか
    
    end
  end


  describe 'POST系　ログインしてないからログイン画面に飛ばされる' do
    let(:user) { create(:user) }
    example 'create' do
      # post user_path(user)  引数とか書き方がおかしいからエラーでる
      post :create, params: {id: user.id} # users_controllerの「create」アクション内で「delete!」が定義されてへんって出るからコメントアウトしてからテスト
      expect(response).to redirect_to new_admin_session_path
    end
    example 'update' do
      # patch user_path(user.id)
      patch :update, params: {id: user.id}
      expect(response).to redirect_to new_admin_session_path
    end
    example 'delete' do
      # delete user_path(user.id)
      delete :destroy, params: {id: user.id}
      expect(response).to redirect_to new_admin_session_path
    end
  end

end
