Rails.application.routes.draw do
  resources :members
  patch 'members/:member_name/friends', to: 'members#add_friend'
  get 'members/name/:member_name', to: 'members#member_by_name'
  get 'experts', to: 'members#find_experts'
end
