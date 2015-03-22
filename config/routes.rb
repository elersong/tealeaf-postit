PostitTemplate::Application.routes.draw do
  
  root to:              'posts#index'
    
  get   '/login', to:     'sessions#new',     as:       'login'
  post  '/login', to:     'sessions#create'
  get   '/logout', to:    'sessions#destroy', as:       'logout'
  get   '/register', to:  'users#new',        as:       'register'
  
  resources :posts,       except: [:destroy] do
    member do
      post :vote  # nest the vote route as exposed to each MEMBER of the :posts resource
    end
    
    resources :comments,  only: [:create] do
      member do
        post :vote  # nest the vote route as exposed to each MEMBER of the :posts resource
      end
    end
  end
  
  resources :categories,  only: [:new, :create, :show]
  resources :users,       only: [:edit, :create, :update, :show] # :new has a named route to '/register'

end
