Rails.application.routes.draw do
  resources :appointments
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
   get 'appointments/index'
   root 'appointments#index'
   post 'appointmentsSearch', to: 'appointments#search'
   get 'appointmentsSearch', to: 'appointments#search.json'
end
