Rails.application.routes.draw do
  # get "/" => "home#index"
  # get 'new' => "home#new"
  
  get '/' => "home#new"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post "create" => "home#create"

end
