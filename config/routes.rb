ActionController::Routing::Routes.draw do |map|
  map.root :controller => 'pages', :action => 'home'
  map.contact '/contact', :controller => 'pages', :action => 'contact'
  map.about '/about', :controller => 'pages', :action => 'about'
  map.help '/help', :controller => 'pages', :action => 'help'
  map.signin '/signin', :controller => 'pages', :action => 'home'

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
