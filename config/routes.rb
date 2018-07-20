Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "sessions#new"
    get "/help", to: "static_pages#help"
    get "/about", to: "static_pages#about"
    get "/contact", to: "static_pages#contact"
    get "/signup", to: "users#new"
    post "/signup", to: "users#create"
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    resources :users
    get "search", to: "search#index"
    get "books/:id/borrow" => "books#borrow", :as => :borrow_book
    get "requests/:data/index" => "requests#index", :as =>:check_user_history
    get "requests/:id/request" => "requests#request_book", :as => :request_book
    get "requests/:id/cancel" => "requests#request_cancel", :as => :request_cancel
    get "requests/:id/approve" => "requests#request_approve", :as => :request_approve
    get "books/:id/return" => "books#return", :as => :return_soon
    get "books/:id/cancel_request" => "books#cancel_request", :as => :cancel_request_book
    resources :books
    resources :requests
    resources :categories
    resources :posts
    match ":controller(/:action(/:id))", :via=> :get
  end
end
