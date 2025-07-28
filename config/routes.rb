Rails.application.routes.draw do
  devise_for :users

  namespace :api do
    namespace :v1 do
      resources :dreams
    end
  end

  root "api/v1/dreams#index"
end
