class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_filter :check_authentication
  
  def check_authentication
    session[:token] ? true : authenticate
  end 
  
  def authenticate
    puts "Authenticating user..."
    response = RestClient.post I18n.t('canvas_url')+I18n.t('authenticate') , {accept: 'json'}
    hash = JSON.parse(response.body)
    if hash.has_key? "token"
      session[:token] = hash["token"]
      return true
    end 
    return false 
  end 
  
end
