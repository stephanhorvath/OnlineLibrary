class SessionsController < ApplicationController
  before_action :is_not_logged_in, only: [:new, :create]

  def new
  end

  def create
    # Find the user in the 'users' table that has the email submitted
    # that is stored in the session hash's email key
    user = User.find_by(email: params[:session][:email].downcase)

    # If a user has been found, because objects in rails are true
    # and user.authenticate (method comes from the has_secure_password attribuet)
    # is equals to true, with the password stored in the session hash's password key
    # Log the user in
    if user && user.authenticate(params[:session][:password])
      # Using log_in method from SessionsHelper
      # which creates a temporary session for the user
      session[:cart] = []
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_back_or user
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    session[:cart] = []
    log_out if logged_in?
    redirect_to root_url
  end

  private

    def is_not_logged_in
      if logged_in?
        flash[:danger] = "You are already logged in"
        redirect_to root_url
      end
    end

end
