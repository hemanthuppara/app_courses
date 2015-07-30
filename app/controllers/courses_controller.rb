class CoursesController < ApplicationController
     
  def index
    response = RestClient.get courses_url , {:params => authenticate_params}
    hash = JSON.parse(response.body)
    p hash
    @courses = hash
  end 
  
  def show
    response = RestClient.get  courses_url+"/#{params[:id]}", {:params => query_params}
    hash = JSON.parse(response.body)
    @course = hash
  end 
  
  private
      
  def authenticate_params
     {accept: 'json', access_token: session[:token]}   
  end 
  
  def courses_url
     I18n.t('canvas_url')+I18n.t('courses') 
  end 
end 