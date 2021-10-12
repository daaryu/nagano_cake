Rails.application.routes.draw do
  devise_for :customers, controllers: {
    registlations: 'public/registlations',
    sessions: 'public/sessions'
  }
  devise_for :admins,skip: [:registlations, :passwords], controllers: {
    sessions: 'admin/sessions'
  }

scope module: :public do
  root to: 'homes#top'
  get 'homes/about' => 'homes#about'

  get 'items/index' => 'items#index'
  get 'items/show' => 'items#show'


  get 'customers/my_page' => 'customers#show'
  get 'customers/edit' => 'customers#edit'
  patch 'customers' => 'customers#update'
  get 'customers/unsubscribe' => 'customers#unsubscribe'
  patch 'customers/quit' => 'customers#quit'

  get 'cart_items' => 'cart_items#index'
  patch 'cart_items/:id' => 'cart_items#update'
  delete 'cart_items/:id' => 'cart_items#destroy'
  delete 'cart_items/destroy_all' => 'cart_items#destroy_all'
  post 'cart_items' => 'cart_items#create'

  get 'orders/new' => 'orders#new'
  post 'orders/confirm' => 'orders#confirm'
  get 'orders/thanks' => 'orders#thanks'
  post 'orders' => 'orders#create'
  get 'orders' => 'orders#index'
  get 'orders/:id' => 'orders#show'

  get 'addresses' => 'adresses#index'
  get 'addresses/:id/edit' => 'adresses#edit'
  post 'addresses' => 'adresses#create'
  patch 'addresses/:id' => 'addresses#update'
  delete 'addresses/:id' => 'addresses#destroy'


end

namespace :admin do
  root to: 'homes#top'

  resources :items, except: [:destroy]

  resources :genres, only: [:index, :create, :edit, :update]


  resources :customers, only: [:index, :show, :edit, :update]

  resources :orders, only: [:show, :update]

  resources :order_details, only: [:update]




end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
