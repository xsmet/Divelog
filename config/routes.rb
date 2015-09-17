Rails.application.routes.draw do
  get 'password_resets/new'
  get 'password_resets/edit'
  root                'static_pages#home'     #root_path
  get    'help'    => 'static_pages#help'     #help_path
  get    'about'   => 'static_pages#about'    #about_path
  get    'contact' => 'static_pages#contact'  #contact_path
  get    'signup'  => 'users#new'             #signup_path
  get    'login'   => 'sessions#new'          #login_path
  post   'login'   => 'sessions#create'       #login_path
  delete 'logout'  => 'sessions#destroy'      #logout_path
  
  resources :dives,               only: [:create, :destroy]
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :microposts,          only: [:create, :destroy]
  resources :relationships,       only: [:create, :destroy]
  resources :users do
    member do # 'member' arrangers urls like /users/1/followers,
              # as opposed to 'collection', which would route to /users/followers
              # named routes are: following_user_path(1), followers_user_path(1)
      get :following, :followers
    end
  end
  # Makes Users a RESTful resource, generating all the following routes:
  # METHOD  URL            ACTION
  # [GET]   /users       : index
  # [GET]   /users/1     : show
  # [GET]   /users/new   : new
  # [POST]  /users       : create
  # [GET]   /users/1/edit: edit
  # [PATCH] /users/1     : update 
  # [DELETE]/users/1     : destroy
end
