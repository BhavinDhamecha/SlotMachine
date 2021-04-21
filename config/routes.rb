Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  devise_scope :user do
    root to: "devise/sessions#new"
  end
  resources :pages, only: [] do
    collection do
      get :home
      get :run_machine
      get :cash_out
    end
  end
  # get '/home', to: 'pages#home'
  # get '/run_machine', to: 'pages#run_machine'
  # get '/cash_out', to: 'pages#cash_out'
end
