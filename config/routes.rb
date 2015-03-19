PostitTemplate::Application.routes.draw do
  
  root to:              'posts#index'
    
  get   '/login', to:   'sessions#new',     as:       'login'
  post  '/login', to:   'sessions#create'
  get   '/logout', to:  'sessions#destroy', as:       'logout'
  get   '/register', to:'users#new'
  
  resources :posts,       except: [:destroy] do
    resources :comments,  only: [:create]
  end
  
  resources :categories,  only: [:new, :create, :show]
  resources :users,       only: [:edit, :create, :update, :show] # :new has a named route to '/register'

end
