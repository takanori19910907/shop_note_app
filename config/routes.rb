Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end

    root 'notes#index'
    get '/tutorial_top', to: 'home#t_top'
    get '/tutorial_1', to: 'home#t_post'
    get '/tutorial_2', to: 'home#t_create'
    get '/tutorial_3', to: 'home#t_favItem_post'
    get '/tutorial_4', to: 'home#t_index'
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
        post :request_user
        post :request_cancle
        post :join
        post :refuse
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
