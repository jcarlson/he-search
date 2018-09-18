Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :searches, path: '/search', as: :search, param: :term, only: [:index, :create, :show]
end
