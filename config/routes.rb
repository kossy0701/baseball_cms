Rails.application.routes.draw do

  root 'top#index'

  get 'about' => 'top#about', as: 'about'

  resources :members do
    get 'search', on: :collection
  end

  resources :articles do
    get 'search', on: :collection
  end

  resource :session, only: [:create, :destroy]
  resource :account, only: [:show, :edit, :update]
  resource :password, only: [:show, :edit, :update]

end
