Rails.application.routes.draw do

  get 'sessions/new'

  root 'static#home'
  get  '/member/home', to: 'static#member_home'

  get '/',        to: 'static#home'
  get '/about',   to: 'static#about'
  get '/contact', to: 'static#contact'

  get '/subscriptions', to: 'subscriptions#index'

  # Routes for unlimited paperback subscriptions
  get 'subscribe/paperback2u', to: 'members#new', :plan_id => 1
  get 'subscribe/paperback4u', to: 'members#new', :plan_id => 2
  get 'subscribe/paperback6u', to: 'members#new', :plan_id => 3

  # Routes for unlimited audiobook subscriptions
  get 'subscribe/audiobook2u', to: 'members#new', :plan_id => 4
  get 'subscribe/audiobook4u', to: 'members#new', :plan_id => 5
  get 'subscribe/audiobook6u', to: 'members#new', :plan_id => 6

  resources :subscriptions do
    resources :members
  end

  resources :members do
    resources :loans
  end

  get    '/login', to: 'sessions#new'
  post   '/login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  resources :books
  put 'add_to_cart', to: 'books#add_to_cart'
  put 'remove_from_cart', to: 'books#remove_from_cart'

  resources :loans
  resources :loan_lines

  resources :products

  # User parent class
  # Members inherits from User
  # Employees inherits from User
  # Managers, Membership_Clerks and Booking Clerks inherit from Employees
  #
  # 'resources' means that they all have get, post, path and delete HTTP verbs
  resources :users
  # resources :members
  resources :membership_clerks
  resources :employees
  resources :managers
  resources :booking_clerks

  resources :charges
  
end
