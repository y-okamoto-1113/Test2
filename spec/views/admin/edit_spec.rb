require 'rails_helper'
# binding.pry
RSpec.describe 'Pages', type: :request do
  describe 'GET #edit' do
    describe 'with authentication' do # describeの下に作るテストグループは「describe」「context」どっちでもいい
      login
      # adminでログインしてから、editアクションに入る。
      example 'return success status' do   # rspecのテスト1個1個は「it」か「example」。どっちでもいい
        get '/users/3/edit'       # 「/users/:id/edit」だとidが番号に変換されへんから。番号を直接埋め込む
        expect(response).to have_http_status(:success)
      end
    end
    describe 'without authentication' do
      # ログインせずに、editアクションに入る。
      example 'return fail status' do
        get '/users/3/edit'
        expect(response).to have_http_status(302)
      end
    end
  end
end