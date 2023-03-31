class StaticPagesController < ApplicationController
  
  require 'flickr'
  
  def index 
    flickr_params
    begin
      # make API connection / Instantiate a new object
      flickr = Flickr.new
      unless params[:flickr_user_id].blank?
        @photos = flickr.photos.search(user_id: params[:flickr_user_id])
      else
        @photos = flickr.photos.getRecent
      end 
    rescue => e
      flash[:alert] = "#{e.class}: #{e.message}. Please try again..."
      redirect_to root_path
    end
  end  

  private

  def flickr_params
    params.permit(:flickr_user_id, :commit)
  end

end
