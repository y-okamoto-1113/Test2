# frozen_string_literal: true

class Admins::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  # before_action :authenticate_admi!

  def login_form
    @admin = Admin.new
  end


  def signup
    # binding.pry
    # super
    @admin = Admin.find_by(email: params[:email],
                           encrypted_password: params[:encrypted_password]) # passwordがnilになってる
    # binding.pry

    if @admin
      # binding.pry

      flash[:notice] = "ログインに成功しました"
      # binding.pry
      redirect_to("/admin_index")
    else
      # binding.pry

      flash[:login_fail] = "メールアドレスまたは電話番号が間違っています！"
      @admin = Admin.new
      @admin.email = params[:email]
      # @admin.encrypted_password = params[:encrypted_password]   # パスワードは消えてるほうがいい
      # binding.pry

      render("admins/sessions/login_form") #@admin のデータ
      return
    end
    # binding.pry

  end


  def index
    @users = User.all.order(created_at: :desc)

  end

  def login01

  end

  def register

  end
  
  def fly
    redirect_to("/admin_login") #renderしてもURLはsignupのまんま。そのまま更新されたり、signupに直でアクセスされたらエラー出るから、login_formに飛ばしたる。
  end

  # GET /admin/sign_in
  # def new
  #   super
  # end

  # POST /admin/sign_in
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
