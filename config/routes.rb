Rails.application.routes.draw do
 
 
 devise_for :customers, skip:[:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

 devise_for :admin, skip:[:registrations, :passwords], controllers: {
  sessions: "admin/sessions"
}

resources :items, only:[:index, :show]

namespace :public do
  resources :customers, only:[:show, :edit, :update, :unsubscribe, :withdraw]
end


 namespace :admin do
   resources :genres, only:[:index, :create, :edit, :update] 
   resources :items, only:[:new, :create, :index, :show, :edit, :update]
   resources :customers, only:[:index, :edit, :update, :show]
  end
  
 root to: 'homes#top'

 get '/home/about' => 'homes#about'

 
 
  


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
