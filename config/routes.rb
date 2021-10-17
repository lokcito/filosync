Rails.application.routes.draw do
  root 'contact#index'
  resources :contact, only: [:index, :create] do 
    collection do 
      get :_filter
      get :filter
      get :files
      post :check
    end
  end
  resources :data_file, only: [:index, :create, :show] do 
    member do 
      post :sync
    end
    collection do 
      get :_filter
    end
  end
  resources :issue_file, only: [] do 
    collection do 
      get :_filter
    end
  end
  devise_for :users
end
