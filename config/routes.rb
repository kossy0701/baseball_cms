Rails.application.routes.draw do

  root 'top#index'
  get 'about' => 'top#about', as: 'about'

  resources :members, only: [:index, :show] do
    get 'search', on: :collection
    resources :entries, only: :index
  end

  resources :articles, only: [:index, :show] do
    resources :comments, only: :create
    get 'search', on: :collection
  end

  resources :entries do
    resources :comments, only: :create
    patch 'like', 'unlike', on: :member
    get 'voted', on: :collection
    resources :images, controller: 'entry_images' do
      patch :move_higher, :move_lower, on: :member
    end
  end

  resource :session, only: [:create, :destroy]
  resource :account, only: [:show, :edit, :update]
  resource :password, only: [:show, :edit, :update]

  namespace :admin do
    root 'top#index'
    resources :members do
      get 'search', on: :collection
      get 'download', on: :collection, as: 'download'
    end
    resources :articles do
      resources :comments, only: :create
      get 'search', on: :collection
    end
    resources :activity_logs, only: :index do
      get 'download', on: :collection, as: 'download'
    end
  end

end
