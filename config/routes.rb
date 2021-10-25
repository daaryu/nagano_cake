Rails.application.routes.draw do
  devise_for :customers, skip: [:passwords,], controllers: {
    registlations: 'public/registlations',
     sessions: 'public/sessions'
   }
  # devise_for :customers, skip: :all
  # devise_scope :customer do
  #   get 'customers/sign_in' => 'customers/sessions#new', as: 'new_customers_session'
  #   post 'customers/sign_in' => 'customers/sessions#create', as: 'customers_session'
  #   delete 'customers/sign_out' => 'customers/sessions#destroy', as: 'destroy_customers_session'
  #   get 'customers/sign_up' => 'customers/registrations#new', as: 'new_customers_registration'
  #   post 'customers' => 'customers/registrations#create', as: 'customers_registration'
  #   get 'customers/password/new' => 'customers/passwords#new', as: 'new_customers_password'
  # end

  devise_for :admins,skip: [:registlations, :passwords], controllers: {
    sessions: 'admin/sessions'
  }

scope module: :public do
  root to: 'homes#top'
  get 'homes/about' => 'homes#about'

  resources :items, only:[:index,:show]

  patch 'customers/quit' => 'customers#quit'
  resources :customers, only:[:edit,:update]
  get 'customers/my_page' => 'customers#show'
  get 'customers/unsubscribe' => 'customers#unsubscribe'


   delete 'cart_items/destroy_all' => 'cart_items#destroy_all'
  resources :cart_items, only:[:index,:update,:destroy,:create]
  #似たようなアクションがある時は順番に注意（destroyよりdestroy_allを優先）


  resources :orders, only:[:index,:create,:show,:new]
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
