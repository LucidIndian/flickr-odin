class StaticPagesController < ApplicationController
  
  require 'flickr'
  
  def index 
    begin
    flickr_params
    # make API connection / Instantiate a new object
    flickr = Flickr.new
    unless params[:flickr_user_id].blank?
      @photos = flickr.photos.search(user_id: params[:flickr_user_id])
    else
      @photos = flickr.photos.getRecent
    end 
  end

  rescue StandardError => e
    flash[:alert] = "#{e.class}: #{e.message}. Please try again..."
    redirect_to root_path
  end

  private

  def flickr_params
    params.permit(:flickr_user_id)
  end

end
