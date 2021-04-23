Rails.application.routes.draw do
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace 'api' do


    resources :posts do 
      resources :comments
      resources :tags
    end
  
    resources :users, only:[:create] 
    post "users/login", to: "users#login"
    get "users/auto_login", to: "users#auto_login"

    

  end

end
