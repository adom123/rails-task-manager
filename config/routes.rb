Rails.application.routes.draw do
  get 'tasks/index'
  get 'tasks/show'
  get 'tasks/new'
  get 'tasks/show'
  get 'tasks/create'
  get 'tasks/update'
  get 'tasks/delete'
	resources :tasks
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
