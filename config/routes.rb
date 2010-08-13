ActionController::Routing::Routes.draw do |map|
  #Header Routes
  map.root :controller => 'pages', :action => 'home'
  map.help '/help', :controller => 'pages', :action => 'help'

  #Footer Routes
  map.contact '/contact', :controller => 'pages', :action => 'contact'
  map.about '/about', :controller => 'pages', :action => 'about'

  #Home page Routes
  map.signup '/signup', :controller => 'users', :action => 'new'

  map.resources :users
  
  map.resources :sessions, :only => [:new, :create, :destroy]
  map.signin '/signin', :controller => 'sessions', :action => 'new'
  map.signout '/signout', :controller => 'sessions', :action => 'destroy'
  

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
