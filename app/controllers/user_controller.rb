class UserController < ApplicationController
   include ApplicationHelper
   before_filter :protect, :only=> :index

  def index
    redirect_to :controller=>"wedding", :action=>"index"

  end

def onlykhurramhavetoregister
@title = "Register"
if param_posted?(:user)
@user = User.new(params[:user])
if @user.save
@user.login!(session)
flash[:notice] = "User #{@user.invitee_name} created!"
redirect_to_forwarding_url

redirect_to :action => "index"
 else
  @user.clear_password!
end
end
end
  def login
@title = "Log in to AnSWedding"
if param_posted?(:user)
@user = User.new(params[:user])
user = User.find_by_invitee_name_and_password(@user.invitee_name,@user.password)
if user
user.login!(session)
flash[:notice] = "You (#{user.invitee_name}) are invited in AnSWedding!"
redirect_to_forwarding_url
else
# Don't show the password again in the view.
@user.clear_password!
flash[:notice] = "Invalid invitee name/password combination"
end
end
  end
  # Log a user out.
  def logout
User.logout!(session)
flash[:notice] = "Logged out"
redirect_to :action => "login", :controller => "user"
  end
  private
# Protect a page from unauthorized access.
def protect
unless logged_in?
session[:protected_page] = request.request_uri
flash[:notice] = "Please log in first"
redirect_to :action => "login"
return false
end
end
  # Return true if a parameter corresponding to the given symbol was posted.
def param_posted?(symbol)
request.post? and params[symbol]
end
  # Redirect to the previously requested URL (if present).
def redirect_to_forwarding_url
if (redirect_url = session[:protected_page])
session[:protected_page] = nil
redirect_to redirect_url
else
redirect_to :controller=> "wedding", :action => "index"
end
end

  end
