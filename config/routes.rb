Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end

  root 'home#top'
  get  'help', to: 'home#help'
  get  'index', to: 'notes#index'
  post 'notes', to: 'notes#create'
  post 'note', to: 'notes#destroy'
  post 'count', to: 'notes#count'
  get  'search_top', to: 'searches#top'
  get  'search_index', to: 'searches#index'

  resources :home

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
      post :create_post
      post :destroy_post
    end
  end

  resources :favorite_items, only: [:index, :create, :new] do
    collection do
      delete :destroy
      post :post
    end
  end

  resources :reviews

  resources :tutorials do
    collection do
      get :post
      get :new_favitem
      get :favitem_index
      get :posted_index
      post :create_note
      post :create_favitem
      post :post_favitem
    end
  end
end
