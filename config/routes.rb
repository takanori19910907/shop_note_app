Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
    # get 'users/index', to: 'users/registrations#index'
  }
    root 'home#index'
    get '/tutorial_top', to: 'home#tutorial_top'
    get '/tutorial_note', to: 'home#tutorial_note'
    get '/tutorial_note_index', to: 'home#tutorial_note_index'
    get '/tutorial_create_f_item', to: 'home#tutorial_create_f_item'
    get '/tutorial_index_f_item', to: 'home#tutorial_index_f_item'
    get '/tutorial_group_create', to: 'home#tutorial_group_create'
    get '/help', to: 'home#help'
    post 'notes', to: 'notes#create'
    post 'note', to: 'notes#destroy'
    post 'count', to: 'notes#count'
    get 'search_top', to: 'searches#top'
    get 'search_index', to: 'searches#index'

    resources :comments, only: [:create, :destroy]

    resources :groups do
      collection do
        get :request_list
      end
      member do
        get :chatroom
        post :invite
        post :invite_reset
        post :join
      end
    end

    resources :favorite_items, only: [:index, :create, :new] do
      collection do
        delete :destroy
        post :post
      end
    end

    resources :reviews
end
