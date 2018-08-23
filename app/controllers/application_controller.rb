class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  before_action :set_session_cart

  private

   def set_session_cart
     session[:cart] ||= []
   end
end
