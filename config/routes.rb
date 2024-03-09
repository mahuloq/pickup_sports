Rails.application.routes.draw do
  get 'web/bootstrap'
  get 'sessions/create'
  resources :sports

  
  scope '/' do
    post 'login', to: 'sessions#create'
  end
  resources :events
  scope :profiles do
    get ':username', to: "profiles#show"
  end
  resources :posts
  resources :users do
    get 'posts', to: "users#posts_index"
  end

  
end