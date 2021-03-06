Rails.application.routes.draw do

  match 'remote_sign_up', to: 'remote_content#remote_sign_up', via: [:get]
  match 'remote_sign_in', to: 'remote_content#remote_sign_in', via: [:get]
  match 'remote_sign_in', to: 'remote_content#remote_sign_out', via: [:get]
  match 'new_user_password', to: 'remote_content#remote_recover_password', via: [:get]

  match 'activate_paypal', to: 'listings#activate_paypal', via: [:get]
  
  devise_for :views
  # devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }
  devise_for :users, controllers: { sessions: 'sessions', registrations: 'registrations' }

  resources :listings do
    resources :favourites
    resources :comments
      get 'listings/(:listing)/comments/new/(:parent_id)', to: 'comments#new', as: :new_comment
  end

  resources :conversations do
    resources :messages
  end
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'listings#index'
  # root to: 'high_voltage/pages#show', id: 'home'


  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  resources :users
  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  #paypal payments
  post "/listings/:id" => "listings#show"
  post "/hook" => "listings#hook"
end
