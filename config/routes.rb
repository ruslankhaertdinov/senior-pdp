Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "users/registrations" }
  resources :locations, only: [] do
    get :fetch, on: :collection
  end
  resources :authors, only: [] do
    get :search, on: :collection
  end
  resources :articles, only: %i(index)
  resources :charges, only: %i(new create)
  root to: "pages#home"
end
