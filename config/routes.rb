Rails.application.routes.draw do
 	root 	'sessions#home'
 	get 	'login' => 'sessions#new'
 	post 	'login' => 'sessions#create'
 	delete 	'logout' => 'sessions#destroy'
	resources :users
	resources :posts, only: [:new, :create, :index]
end
