Rails.application.routes.draw do
  root 'static_pages#home'
  get '/about' => 'static_pages#about'
  get '/signup' => 'users#new'
  get '/signin' => 'sessions#new'
  # get '/users/:id/sentiments/:id' => 'tweet_sentiments#show', as: :tweet_sentiment
  # get '/search' => 'searches#new'  # search input text field and submit button
  # get '/search/:term' => 'searches#index', as: :results
  delete '/tweet_sentiments/:id' => 'tweet_sentiments#destroy'
  delete '/signout' => 'sessions#destroy'
  resources :tweet_sentiments, only: [:index, :show, :create]
  resources :sessions, only: [:create]
  resources :users, except: [:new]
  resources :searches, only: [:index, :new]
  # post 'users/create' => 'users#create' 
  # get 'users/:id' => 'users#show', :as => :user
  # get 'users/' => 'users#index', :as => :users
  # get 'users/:id/edit' => 'users#edit'
  # patch 'users/:id' => 'users#update'
  # delete 'users/:id' => 'users#destroy'









  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

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
end
