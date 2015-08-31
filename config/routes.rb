Rails.application.routes.draw do

  devise_for :users, :controllers => {:registrations => "registrations"}
  get 'profile' => "users#profile"
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#index'
  
  # Search and loading more data for books and comics are started here.....
  get "/load_more_books" => "home#load_more_books"
  get "/load_more_comics" => "home#load_more_comics"
  get "/search" => "home#search"
  
  
  #post "/book_filter" => "books#filter", :as => "book_filter"
  #get "/book_filter" => "comics#filter", :as => "comic_filter"
  
  # CRUD on the Books and Comics routes started here.....
  resources :users do
    get "/feed" => "home#feed", :as => "content_feed"
    resources :books, except: :show, param: :slug
    resources :comics, except: :show, param: :slug
  end
  
  # Viewing Books and Comics routes started here.....
  resources :books, only: :show, param: :slug do
    collection do
      get "/:slug/like" => "books#like", :as => "like"
      get "/:slug/dislike" => "books#dislike", :as => "dislike"
    end
  end
  resources :comics, only: :show, param: :slug do
    collection do
      get "/:slug/like" => "comics#like", :as => "like"
      get "/:slug/dislike" => "comics#dislike", :as => "dislike"
    end
  end
  resources :bookmarks, only: [:create, :update]
  
  # Comments and Replies routes started here.....
  resources :comments, only: [:create, :update, :destroy]
  
  # Votes for the Books and Comics started here.....
  
  get "/:id/like" => "votes#like", :as => "like"
  get "/:id/dislike" => "votes#dislike", :as => "dislike"
  
  # Static Pages routes started here.....
  get 'about' => 'static_pages#about'
  get "legal" => 'static_pages#legal'
  get "faq"   => 'static_pages#faq'
  

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
