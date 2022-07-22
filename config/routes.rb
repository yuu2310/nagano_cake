Rails.application.routes.draw do
 
 
 devise_for :customers, skip:[:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

 devise_for :admin, skip:[:registrations, :passwords], controllers: {
  sessions: "admin/sessions"
}



scope module: :public do
  root to: 'homes#top'
  get '/about' => 'homes#about'
  resources :items, only:[:index, :show]
  get '/customers/my_page' => 'customers#show'
  get '/cuntomers/unsubscribe' => 'customers#unsubscribe'
  patch '/customers/withdraw' => 'customers#withdraw'
  resources :customers, only:[:edit, :update]
  resources :addresses, only:[:index, :edit, :create, :update, :destroy]
  post '/orders/confirm' => 'orders#confirm'
  get '/orders/complete' => 'orders#complete'
  resources :orders, only:[:new, :create, :index, :show]
  delete '/cart_items/destroy_all' => 'cart_items#destroy_all'
  resources :cart_items, only:[:index, :update, :destroy, :create]
  
end


 namespace :admin do
  root to: 'homes#top'
  resources :genres, only:[:index, :create, :edit, :update] 
  resources :items, only:[:new, :create, :index, :show, :edit, :update]
  resources :customers, only:[:index, :edit, :update, :show]
  end

 
 
  


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
