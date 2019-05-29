Rails.application.routes.draw do

  root 'top#index'
  get 'about' => 'top#about', as: 'about'

  resources :members, only: [:index, :show] do
    get 'search', on: :collection
    resources :entries, only: :index
  end

  resources :articles, only: [:index, :show] do
    get 'search', on: :collection
  end

  resources :entries do
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
    end
    resources :articles do
      get 'search', on: :collection
    end
    resources :activity_logs, only: :index
  end

end
