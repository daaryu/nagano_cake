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


  get 'customers/my_page' => 'customers#show'
  get 'customers/edit' => 'customers#edit'
  patch 'customers' => 'customers#update'
  get 'customers/unsubscribe' => 'customers#unsubscribe'
  patch 'customers/quit' => 'customers#quit'


end

namespace :admin do
  root to: 'homes#top'


  resources :customers, only: [:index, :show, :edit, :update]

end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
