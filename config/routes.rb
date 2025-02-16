# frozen_string_literal: true

Rails.application.routes.draw do
  root 'user_books#index'

  devise_for :admins, controllers: { omniauth_callbacks: 'admins/omniauth_callbacks' }
  devise_scope :admin do
    get 'admins/sign_in', to: 'admins/sessions#new', as: :new_admin_session
    get 'admins/sign_out', to: 'admins/sessions#destroy', as: :destroy_admin_session
  end

  resources :user_books
  resources :users

  resources :books do
    member do
      get 'delete'
    end
  end
end
