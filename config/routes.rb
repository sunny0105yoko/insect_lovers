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
 
 resources :users, only: [:index] do
  collection do
  get 'show', to: 'users#show', as: 'current_user'
  get 'information/edit', to: 'users#edit', as: 'edit_current_user'
  patch 'update', to: 'users#update', as: 'update_current_user'
  end
end
end


namespace :admin do
  root to: 'homes#top'
  resources :lists, only: %i[index show edit update destroy]
  resources :users, only: %i[index show]
end
end
