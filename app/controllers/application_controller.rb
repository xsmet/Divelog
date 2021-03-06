class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  # All controllers can access the SessionsHelper
  include SessionsHelper

  private
  
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
    
    # XHR (AJAX) needs a flash.now message, because otherwise
    # the flash message would persist on the next normal page request
    def flash_message(type, message)
      if request.xhr?
        flash.now[type] = message
      else
        flash[type] = message
      end
    end
    
end
