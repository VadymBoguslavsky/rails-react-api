Rails.application.routes.draw do
  resources :todos do
    member do
      get :completed
    end
    collection do
      post :sort
    end
  end


  resources :users do
    member do
      get :confirm_email
    end
    collection do
      post :fetch_token
      post :create_token
      post :destroy_token
    end
  end

end
