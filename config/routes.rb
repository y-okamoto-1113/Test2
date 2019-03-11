Rails.application.routes.draw do
  devise_for :admins do
    get '/admins/sign_out' => 'devise/sessions#destroy'
  end
  resources :users do
    post '/create' => "users#create"
    # post '/users/:id' => 
  end
  root "users#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
