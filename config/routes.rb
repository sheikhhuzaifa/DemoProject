# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :leads
    end
  end
  root to: "leads#index"

  get "/emails", to: "pages#email"
  get "/assigned_phases", to: "pages#assigned_phases"

  resources :pages, only: [] do
    member do
      patch "accept_phase"
      patch "decline_phase"
    end
  end

  devise_for :users, controllers: { registration: "users/registration" }

  resources :leads do
    resources :phases
  end
  resources :phases do
    resources :comments, module: :phases
  end

  resources :projects do
    resources :comments, module: :projects
  end
  resources :leads do
    resources :comments, module: :leads
  end

  resources :projects do
    member do
      patch "assign_manager", to: "projects#assign_manager"
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
