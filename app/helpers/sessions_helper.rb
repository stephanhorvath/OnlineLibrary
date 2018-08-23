module SessionsHelper

  # Logs user in
  def log_in(user)
    session[:user_id] = user.id
  end

  def add_book
    session[:cart] ||= []
  end

  # Remembers user in persistent session
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  # Returns true if the given user is the current user
  def current_user?(user)
    user == current_user
  end

  # Assigns a user (if logged in) to current_user
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  def is_manager?
    current_user.type == "Manager"
  end

  def is_member?
    current_user.type == "Member"
  end

  # Returns true if user is logged in
  def logged_in?
    !current_user.nil?
  end

  # Forgets a persistent session
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  # Logs out current user
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

  # Redirects to stored location (or to the default).
  def redirect_back_or(default)
    redirect_to(session[:fowarding_url] || default)
    session.delete(:fowarding_url)
  end

  # Stores the URL trying to be accessed
  def store_location
    session[:fowarding_url] = request.original_url if request.get?
  end
end
