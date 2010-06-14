ActionController::Routing::Routes.draw do |map|
  #Header Routes
  map.root :controller => 'pages', :action => 'home'
  map.help '/help', :controller => 'pages', :action => 'help'
  map.signin '/signin', :controller => 'pages', :action => 'home'

  #Footer Routes
  map.contact '/contact', :controller => 'pages', :action => 'contact'
  map.about '/about', :controller => 'pages', :action => 'about'

  #Home page Routes
  map.signup '/signup', :controller => 'users', :action => 'new'

  map.resources :users

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
