Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      get 'merchants/find', to: "merchants#find"
      resources :merchants, only: [:index, :show]
      get 'merchants/:id/items', to: "merchants#items"
      get 'items/find_all', to: "items#find_all"
      resources :items, only: [:index, :show, :create, :destroy, :update ]
      get 'items/:id/merchant', to: "items#merchant"
    end
  end
end
