# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root 'questions#index'

  resources :attachments, only: :destroy

  resources :questions do
    resources :answers, shallow: true, only: %i[create destroy update]

    member do
      post 'best_answer/:best_answer_id', to: 'questions#best_answer', as: 'best_answer'
    end
  end
end
