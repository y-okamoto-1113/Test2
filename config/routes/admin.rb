Rails.application.routes.draw do
 
  devise_for :admin #, :class_name => 'Admin' ここなくていいかも # class_nameは大文字モデルの名前を引数にとる
  devise_scope :admin do # なんのモデルに対してのルーティングかを明記しなあかん
    post "admin_signup" => "admins/sessions#signup"
    get 'admin_login' => "admins/sessions#login_form"
    get "admin_index" => "admins/sessions#index"
    get "admin_signup" => "admins/sessions#fly"

    get 'login01' => "admins/sessions#login01"
    get "register" => "admins/sessions#register"
  end

end