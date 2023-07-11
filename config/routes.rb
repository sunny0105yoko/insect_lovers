Rails.application.routes.draw do
  # 顧客用
  # URL /users/sign_in ...
  devise_for :users,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin,skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  scope module: :public do
    root to: 'homes#top'
    get '/about', to: 'homes#about'

    resources :lists, only: %i[new create index destroy show edit update] do
      resources :post_comments, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy]
    end

    resources :users, only: %i[index show edit update] do
      resource :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers' ,as: 'followers'
      member do
      get :favorites
      end
    end
    
    get 'searches/search' => "searches#search"
    resources :chats, only: [:show, :create]
  end

  namespace :admin do
    root to: 'homes#top'
    resources :lists, only: %i[index show edit update destroy]
    resources :users, only: %i[index show]
  end

end
