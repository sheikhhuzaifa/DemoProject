Rails.application.routes.draw do
  root to: "pages#home"

  devise_for :users

  resources :leads do
    resources :phases
  end
  resources :phases do
    resources :comments,module: :phases
  end

  resources :projects do
    resources :comments ,module: :projects

    end
  resources :leads do
    resources :comments,module: :leads
  end

  resources :projects do
    member do
      patch 'assign_manager', to: 'projects#assign_manager'
    end
  end
  resources :phases do
    resources :engineers
  end
  resources :roles, only: [:index] do
    member do
      post :assign_role
      delete :remove_role
    end
  end
end
