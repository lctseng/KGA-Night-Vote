Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Serve websocket cable requests in-process
  mount ActionCable.server => '/cable'
  root 'vote#new'
  get 'vote/result' => 'vote#result', as: :result

  get 'vote/red' => 'vote#view_red', as: :view_red
  get 'vote/white' => 'vote#view_white', as: :view_white

  get 'vote/new' => 'vote#new', as: :new_vote
  post 'vote/create' => 'vote#create', as: :create_vote


end
