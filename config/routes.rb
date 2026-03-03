Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  authenticated :user do
    # takes the current_user's ID and builds the /users/:id/pets path
    root to: redirect { |params, request|
      user = request.env['warden'].user
      "/users/#{user.id}/pets"
    }, as: :authenticated_root
  end

  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  resources :clinics, only: [:index, :show] #showing the clinics to all
  resources :users, only: [:show, :new, :create] do
    resources :pets, only: [:show, :new, :create, :index] do
      member do
      # Add route /users/:user_id/pets/:id/archive
        patch :archive
        # /users/:user_id/pets/:id/unarchive
        patch :unarchive
      end
      resources :logs, only: [:index, :new, :create, :edit, :update, :show] do
        collection do
          post :export
        end
      end
    end
    resources :clinics, except: [:index, :show]
    resources :friendships, except: [:destroy]
    resources :chats, except: [:destroy] do
      member do
        # Add route /users/:user_id/chats/:id/archive
        patch :archive
        # /users/:user_id/chats/:id/unarchive
        patch :unarchive
      end
      resources :messages, except: [:destroy]
    end
  end
end
