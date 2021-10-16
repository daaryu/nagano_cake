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

  resources :items, only:[:index,:show]

  resources :customers, only:[:edit,:update]
  get 'customers/my_page' => 'customers#show'
  get 'customers/unsubscribe' => 'customers#unsubscribe'
  patch 'customers/quit' => 'customers#quit'

  resources :cart_items, only:[:index,:update,:destroy,:create]
  delete 'cart_items/destroy_all' => 'cart_items#destroy_all'

  resources :orders, only:[:index,:create,:show]
  get 'orders/new' => 'orders#new'
  post 'orders/confirm' => 'orders#confirm'
  get 'orders/thanks' => 'orders#thanks'


  resources :addresses, except:[:show,:new]



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
