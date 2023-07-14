Rails.application.routes.draw do

  devise_for :users
  root to: "pages#home"
  resources :roles, only: [:index] do
    member do
      post :assign_role
      delete :remove_role
    end
  end

  resources :leads do
    resources :phases
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
