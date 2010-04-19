ActionController::Routing::Routes.draw do |map|
  map.login 'login',         :controller => 'session',
                             :action => 'new'

  map.logout 'logout',       :controller => 'session',
                             :action => 'destroy'

  map.signup 'signup',       :controller => 'user',
                             :action => 'new'

  map.resource :session,     :controller => 'session'
  map.resource :password,    :controller => 'password'
  map.resource :user,        :controller => 'user',
                             :member => { :verify => :get }

  map.user_verification_sent 'user/verification_sent',
                             :controller => 'user',
                             :action => 'verification_sent'

  map.resources :users,      :path_prefix => "admin",
                             :name_prefix => "admin_global_",
                             :namespace   => "admin/"

  map.resources :users,      :path_prefix => "admin/sites/:site_id",
                             :name_prefix => "admin_site_",
                             :namespace   => "admin/"

  map.user_confirmation      'user/confirmation', :controller => 'user', :action => 'confirm_invitation'

  map.edit_admin_user_profile 'users/:id/edit_profile',
                              :path_prefix => "admin/sites/:site_id",
                              :controller => 'admin/users',
                              :action => 'edit_profile'

  map.edit_user_profile       'user/edit_profile',
                              :controller => 'user',
                              :action => 'edit_profile'
end