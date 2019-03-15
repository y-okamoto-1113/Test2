require 'rails_helper'
# binding.pry
RSpec.describe 'Pages', type: :request do

  describe 'Delete user' do
    context 'with authentication' do
      login
      let(:user) { create(:user) }
      # adminでログインしてから、ユーザー消す。
      it 'return success status' do
        # authenticate
        # binding.pry
        delete '/users/3' #401, 404
        expect(response).to have_http_status(:success)
        # binding.pry
      end
   
      it '2' do
        # delete user
        delete user_url #404
        expect(response).to have_http_status(:success)
      end
    
      it '3' do
        # delete user
        delete user_path #404
        expect(response).to have_http_status(:success)
      end
      
      it '4' do
        # delete user
        # binding.pry
        # authenticate
        # binding.pry
        expect(delete user_path(user.id)).to 200.to_s
        # expect(response).to have_http_status(:success)
      end
    
      it '5' do
        # delete user
        delete user_path(id: 3) #404
        expect(response).to have_http_status(:success)
      end
    
      it '6' do
        # delete user
        delete :destroy, params: { id: user }
        expect(response).to have_http_status(:success)
      end
    
      it '7' do
        # delete user
        delete :destroy, params: { id: user.id }
        expect(response).to have_http_status(:success)
      end
    
      it '8' do
        # delete user
        delete :destroy, params: { id: user.id }
        expect(response).to have_http_status(:success)
      end
    
      it '9' do
        # delete user
        delete delete_user_path params:{id: @user}    #error
        expect(response).to have_http_status(:success)
      end

      it '10' do
        # delete user
        delete 'delete_user' => 'users#destroy'  
        expect(response).to have_http_status(:success)
      end

      it '11' do
        # delete user
        delete :destroy, :params => { id: user.id }
        expect(response).to have_http_status(:success)
      end

      it '12' do
        # delete user
        delete :destroy, :params=> { id: "3" }
        expect(response).to have_http_status(:success)
      end
    end

    # context 'without authentication' do
    #   login
    #   let(:user) { create(:user) }
    #   # adminでログインしてから、ユーザー消す。
    #   it 'return fail status' do
    #     # delete user

    #     expect(response).to have_http_status(302)
    #   end
    # end


    context 'without authentication' do
      # ログインせずに、ユーザー消す。
      it 'return fail status' do
        delete '/users/3'
        expect(response).to have_http_status(302)
      end
    end
  end
end