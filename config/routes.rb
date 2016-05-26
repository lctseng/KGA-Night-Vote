Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Serve websocket cable requests in-process
  mount ActionCable.server => '/cable'
  root 'votes#new'
  
  resource 'vote', only: [:new, :create] do
    member do
      get :result
      get :red, path: 'view_red'
      get :white, path: 'view_white'

      get :settings, action: 'get_settings'
      post :settings, action: 'post_settings'
    end
  end
  

  


end
