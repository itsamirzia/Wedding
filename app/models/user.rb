class User < ActiveRecord::Base
# Max & min lengths for all fields
INVITEE_NAME_MIN_LENGTH = 4
INVITEE_NAME_MAX_LENGTH = 20
PASSWORD_MIN_LENGTH = 4
PASSWORD_MAX_LENGTH = 40
EMAIL_MAX_LENGTH = 50
INVITEE_NAME_RANGE = INVITEE_NAME_MIN_LENGTH..INVITEE_NAME_MAX_LENGTH
PASSWORD_RANGE = PASSWORD_MIN_LENGTH..PASSWORD_MAX_LENGTH
# Text box sizes for display in the views
INVITEE_NAME_SIZE = 20
PASSWORD_SIZE = 10
EMAIL_SIZE = 30
validates_uniqueness_of :email
validates_length_of :invitee_name, :within => INVITEE_NAME_RANGE
  validates_length_of :password, :within => PASSWORD_RANGE
validates_length_of :email, :maximum => EMAIL_MAX_LENGTH
validates_presence_of :email
validates_length_of :invitee_name, :within => INVITEE_NAME_RANGE
validates_length_of :password, :within => PASSWORD_RANGE
validates_length_of :email, :maximum => EMAIL_MAX_LENGTH
validates_format_of :email,
:with => /^[A-Z0-9._%-]+@([A-Z0-9-]+\.)+[A-Z]{2,4}$/i,
:message => "must be a valid email address"
def validate
errors.add(:email, "must be valid.") unless email.include? ("@")

end
  # Log a user in.
def login!(session)
session[:user_id] = id
end
  # Clear the password (typically to suppress its display in a view).
def clear_password!
self.password = nil
end

# Log a user out.
def self.logout!(session)
session[:user_id] = nil
end
end