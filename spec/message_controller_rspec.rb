# createしたadminをletに格納しインスタンス変数のように使用できるようにした。
# さらにそのadminにlogin_adminメソッドを使ってdeviseにログインさせます。

require 'rails_helper'

describe MessagesController, type: :controller do
  let(:admin) { create(:admin) }
  # adminをcreateし、let内に格納

  describe 'GET #index' do
    before do
      login_user admin
      # controller_macros.rb内のlogin_adminメソッドを呼び出し
    end

    it "renders the :index template" do
    end
end