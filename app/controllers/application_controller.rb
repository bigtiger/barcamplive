# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '899abf093c3f8f06fc8860c27936a25b'

  def login
    verify_access and redirect_to root_path
  end

  def logout
    session[:admin] = false
    redirect_to root_path
  end

  def verify_access
    authenticate_or_request_with_http_basic("Admin") do |username, password|
      username == 'admin' && password == 'sw@ll0w' && session[:admin] = true
    end
  end
  protected :verify_access
end
