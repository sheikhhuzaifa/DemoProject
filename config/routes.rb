Rails.application.routes.draw do
  root to: "pages#home"

  devise_for :users

  resources :leads do
    resources :phases
  end

  resources :projects
  resources :phases do
    resources :engineers
  end

  get 'assigned', to: 'pages#assigned_lead', as: 'assigned_leads'
  resources :roles, only: [:index] do
    member do
      post :assign_role
      delete :remove_role
    end
  end
end
