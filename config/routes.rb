Rails.application.routes.draw do
  devise_for :users
  resources :users , only: :show

  resources :prototypes do
    resources :comments, only: [:create, :new]
  end

  root to: "prototypes#index"
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
