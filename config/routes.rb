Rails.application.routes.draw do
  root to: 'pages#home'
  post 'result', to: 'pages#create'
  get 'result', to: 'pages#result'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
