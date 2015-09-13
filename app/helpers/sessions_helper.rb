module SessionsHelper
  
  # Logs in the given user
  # Automagically creates encrypted temporary cookie, which is
  # safe because it's temporary (no session hijacking possible)
  def log_in(user)
    session[:user_id] = user.id
  end
  
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end
  
  # Returns true if the given user is the current user, false otherwise
  def current_user?(user)
    user == current_user
  end
  
  # Returns the current logged-in user (if any)
  # Uses ||=, which is equal to "if @current_user is nil, fetch it from the database":
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(:remember, cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end
  
  # Returns true if a user is logged in, false otherwise
  def logged_in?
    !current_user.nil?
  end
  
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end
  
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end
  
  # Redirects to stored location (or the default)
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end
    
  # Stores the URL trying to be accessed
  def store_location
    # Only store GET requests (don't bother about POST/PATCH/DELETE)
    session[:forwarding_url] = request.url if request.get?
  end
end