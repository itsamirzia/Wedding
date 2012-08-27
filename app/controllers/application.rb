# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  include ApplicationHelper
  before_filter :check_authorization
   session :session_key => '_wedding_session'

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery  :secret => '309f06da341ba36ab333438683dd5be5'

 def check_authorization
authorization_token = cookies[:authorization_token]
if authorization_token and not logged_in?
user = User.find_by_authorization_token(authorization_token)
user.log_in!(session) if userend
end
end
def protect
unless session[:user_id]
flash[:notice] = "Please log in first"
redirect_to :action => "login"
return false
end
end
  end

