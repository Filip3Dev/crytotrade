Rails.application.routes.draw do
  root 'pages#index'

  get '/grafico' => 'pages#grafico', as: :grafico

  devise_for :users

  get '/layout' => 'pages#layout', as: 'modulos'
  get '/widgets' => 'pages#pares', as: 'pares'
  resources :index
  namespace :tv do
    get 'messages/index' => 'messages#index'

  end
  resources :main
  get '/config' => 'main#config', as: 'config'


  namespace :service , defaults: {format: :json} do
    post 'sessions/signin' => 'sessions#create'

    post 'users/create' => 'users#create'
    post 'users/update/:token' => 'users#update'
    delete 'users/destroy/:id/:token' => 'users#destroy'

    post 'messages/create/:token' => 'messages#send_message'
    get 'messages/:token' => 'messages#messages'
    get 'messages/category/:category/:token' => 'messages#message_category'
    delete 'messages/destroy/:id/:token' => 'messages#destroy'



  end
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
