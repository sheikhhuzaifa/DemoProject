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
  resources :projects
  get 'assigned', to: 'pages#assigned_lead', as: 'assigned_leads'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
