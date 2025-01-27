Rails.application.routes.draw do
  root 'books#index'

  resources :books do
    member do
      get 'delete'
    end
  end
end
