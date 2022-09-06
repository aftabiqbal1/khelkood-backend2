Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  
  

  # devise_for :users, skip: [:registrations]
  # as :user do
  #   post 'signup': :'custom_devise_api/custom_registrations/email', as: :user_registration
  #   # post 'custom_registrations/email', to: 'custom_devise_api/custom_registrations#signup_email'
  #   # get 'custom_registrations/login_email', to: 'custom_devise_api/custom_registrations#sigin_email'
  #   # get 'custom_registrations/verify_mobile', to: 'custom_devise_api/custom_registrations#verify_mobile_signin'
  #   # post 'custom_registrations/register_sports_complex', to: 'custom_devise_api/custom_registrations#register_sports_complex'
  #
  #
  # end

  mount_devise_token_auth_for 'User', at: 'auth'
  devise_scope :user do
    post :signup_email, to: 'custom_devise_api/users#signup_email'
    post :signin_email, to: 'custom_devise_api/users#signin_email'
    get :verify_mobile_signin, to: 'custom_devise_api/users#verify_mobile_signin'
    post :register_sports_complex, to: 'custom_devise_api/users#register_sports_complex'
    post :signin, to: 'custom_devise_api/users#signin'
  end

  
  resources :customers do
    post :register_team, on: :collection
  end

  resources :sports_complex do
    post :post_review
  end

  resources :teams do
    post :add_match_stats
  end

  resources :otp do
    get :verify, to: 'otp#verify', on: :collection
  end
end
