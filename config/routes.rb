Rails.application.routes.draw do
  resources :todos
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


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
