Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/shops', to: 'shops#index'
  get '/shops/:id', to: 'shops#show'
  post '/shops', to: 'shops#create'
  delete '/shops/:id', to: 'shops#delete'
  put '/shops/:id', to: 'shops#update'
end
