class CoursesController < ApplicationController
     
  def index
    req_params = authenticate_params
    if params[:url]
      req_params.merge! session[params[:url]]
    end 
    p req_params
    response = RestClient.get courses_url , {:params => req_params}
    
    hash = JSON.parse(response.body)
    @links = {}
    response.headers[:link].split(",").each do |each_link|
      link, linktext = (each_link).split(";")
      links_params = {}
      (URI(URI.encode(link.strip.gsub(/[<|>]/,''))).query).split("&").each do |par|
        name, val = par.split("=")
        next unless ['page', 'per_page'].include? name
        links_params[name] = val
      end 
      linktext = linktext.gsub(/\s*rel=/,"").gsub(/\"/,'')
      session[linktext] = links_params
      @links[linktext] = true 
    end 
    puts @links
    @courses = hash
  end 
  
  def show
    response = RestClient.get  courses_url+"/#{params[:id]}", {:params => authenticate_params}
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