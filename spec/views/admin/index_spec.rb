# 最初の「RSpec.」は書かんくても良い。
# モンキーパッチというパッチがデフォルトで入ってて、これが最初の「RSpec.」を補完してくれてる。
# 他にも色んなコードを補完してくれる便利な機能やけど、どこがどう変更されているかが分からない。
# 一応このままにしとくけど、rails_helperに「config.expose_dsl_globally = false」と書けば、モンキーパッチをオフにできる。

require 'rails_helper'
{ "Host" => "localhost:3000" }
# binding.pry
RSpec.describe 'Pages', type: :request do 
  describe 'GET #index' do
    context 'with authentication' do
      login
      let(:user) { create(:user) }
      # adminでログインしてから、indexアクションに入る。
      it 'return success status' do
        # binding.pry

        get '/'
        # binding.pry
        get '/'
        # binding.pry
        expect(response).to have_http_status(:success)
        # binding.pry
      end
    end
    context 'without authentication' do
      # ログインせずに、indexアクションに入る。
      it 'return fail status' do
        get '/'
        expect(response).to have_http_status(302)
      end
    end
  end
end

# describe 'GET #index' do
#   let(:) { create_list(:article, 2) }
#   before { get :index, params: {}, session: {} }

#   it 'has a 200 status code' do
#     expect(response).to have_http_status(:ok)
#   end

#   it 'assigns @articles' do
#     expect(assigns(:articles)).to match_array articles
#   end

#   it 'renders the :index template' do
#     expect(response).to render_template :index
#   end
# end