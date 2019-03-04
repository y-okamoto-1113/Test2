# frozen_string_literal: true

class Admins::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  def login_form
    @admin = Admin.new
  end


  def signup
    # binding.pry
    @admin = Admin.find_by(email: params[:email],
                           encrypted_password: params[:encrypted_password])
    if @admin
      flash[:notice] = "ログインに成功しました"
      # binding.pry
      redirect_to("admin_index")
    else
      flash[:login_fail] = "メールアドレスまたは電話番号が間違っています！"
      render("devise/sessions/login_form")
    end
  end


  def index
    @users = User.all.order(created_at: :desc)

  end

  def login01

  end

  def register

  end
  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
