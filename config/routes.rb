Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions:      'users/sessions',
    passwords:     'users/passwords',
    registrations: 'users/registrations'
  }
  devise_for :admins, controllers: {
    sessions:      'admins/sessions',
    passwords:     'admins/passwords',
    registrations: 'admins/registrations'
  }

  root to: "users/homes#top"
  get "/about" => "users/homes#about"

  namespace :users do
    resources :posts do
      resources:post_comments, only: [:create, :destroy]
    end

    resources :invites do
      resources:invite_comments, only: [:create, :destroy]
    end

    resources :users, only: [:show, :edit, :update, :destroy] do
      member do
        get "quit"
      end
    end
  end

end
