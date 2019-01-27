Rails.application.routes.draw do
 devise_for :users
 root "root#top"
 get 'root/about'
 resources :books
 resources :users
end
