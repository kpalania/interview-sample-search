Rails.application.routes.draw do
  resources :members
  patch 'members/:member_name/friends', to: 'members#add_friend'
  get 'members/name/:member_name', to: 'members#member_by_name'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html


end
