Rails.application.routes.draw do
  
  # ファイルで分けた場合
  Dir.glob(File.expand_path("#{Rails.root}/config/routes/admin.rb", __FILE__)).each do |file|
    instance_eval(File.read(file))
  end

  get '/' => "home#new"
  post "create" => "home#create"

  # devise_for :admins, :class_name => 'Admin'      # class_nameはモデルの名前を引数にとる

end
