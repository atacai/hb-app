Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'homes#index'
  resources :conferences do
		collection do
			get :change_priority
		end
	end
	resources :proposals
	resources :session_configurations
end
