Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "users/registrations", sessions: "users/sessions", passwords: "users/passwords" }

  resources :locations, only: [] do
    get :fetch, on: :collection
  end

  resources :articles, only: %i(index)
  resources :charges, only: %i(create)

  namespace :account do
    resources :articles
  end

  resources :users, only: [] do
    get :search, on: :collection

    resources :articles, only: %i(index show), controller: "users/articles"
  end

  root to: "pages#home"
end
