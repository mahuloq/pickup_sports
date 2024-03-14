Rails.application.routes.draw do
  get 'web/bootstrap'
  get 'sessions/create'
  resources :sports

  
  scope '/' do
    post 'login', to: 'sessions#create'
  end
  resources :events do
    member do
      #localhorst:3000/events/1/join
      post 'join', to: 'events#join'

      #localhost:3000/events/1/join
      delete 'leave', to: 'events#leave'
    end
  end
    
  
  scope :profiles do
    get ':username', to: "profiles#show"
  end
  resources :posts
  resources :users do
    get 'posts', to: "users#posts_index"
  end

  
end