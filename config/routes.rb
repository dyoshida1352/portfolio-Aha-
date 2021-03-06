Rails.application.routes.draw do

  devise_for :users, controllers: {
    sessions:      'users/sessions',
    passwords:     'users/passwords',
    registrations: 'users/registrations'
  }
  devise_for :admins, controllers: {
    sessions:      'admins/sessions',
    passwords:     'admins/passwords'
  }

  root to: "users/homes#top"
  get "/about" => "users/homes#about"

  namespace :users do
    get "/search" => "searchs#search"
    resources :posts do
      resources:post_comments, only: [:create, :destroy]
      resource :likes, only: [:create, :destroy]
    end

    resources :invites do
      resources:invite_comments, only: [:create, :destroy]
    end

    resources :users, only: [:show, :edit, :update, :destroy] do
      member do
        get "quit"
      end
      resource :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
    end

  end

  namespace :admins do
    resources :users, only: [:index, :show, :edit, :update, :destroy]
    resources :posts, only: [:index, :show, :edit, :update, :destroy]
    resources :invites, only: [:index, :show, :edit, :update, :destroy]
  end

end
