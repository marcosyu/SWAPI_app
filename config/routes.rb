Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :films, only: [:index, :show]

  root to: "films#index"
end
