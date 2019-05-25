Rails.application.routes.draw do

  root 'top#index'
  get 'about' => 'top#about', as: 'about'
  get "bad_request" => "top#bad_request"
  get "forbidden" => "top#forbidden"
  get "internal_server_error" => "top#internal_server_error"


  resources :members do
    resources :entries, only: :index
    get 'search', on: :collection
  end

  resources :articles do
    get 'search', on: :collection
  end

  resources :entries do
    resources :images, controller: 'entry_images'
  end

  resource :session, only: [:create, :destroy]
  resource :account, only: [:show, :edit, :update]
  resource :password, only: [:show, :edit, :update]

end
